# Lunch and Learn

## Learning Goals
- To learn how to write a back-end that both consumes and serves APIs.
- To practice MVC methodology and the use of Facades, "Plain Old Ruby Objects" (POROs), services, and serializers

## Development Setup
This guide assumes you have installed [Rails 7.1.3](https://guides.rubyonrails.org/v7.1/getting_started.html) and [PostgreSQL >= 14](https://www.postgresql.org/download/)

First, clone the repository to your computer

```sh
git clone git@github.com:NeilTheSeal/lunch-and-learn.git
```

Next, install all of the Gems

```sh
bundle install
```

Create, migrate, and seed the databases

```sh
rails db:{create,migrate,seed}
```

Finally, start the development server

```sh
rails s
```

The API will be served on `localhost:3000`.

Run the test suite to diagnose issues -

```sh
bundle exec rspec
```

## API Keys
This API requires API keys for the [Edamam Recipe API](https://developer.edamam.com/edamam-recipe-api), the [YouTube API](https://developers.google.com/youtube/v3/getting-started), and the [Pexels API](https://www.pexels.com/api/). The API keys are stored in the following format in the credentials.yml.enc file:
```
edamam_recipe_api:
  id: ...
  api_key: ...

youtube:
  api_key: ...

pexels:
  api_key: ...
```
To add your API keys to the credentials file, delete the config/credentials.yml.enc file, then execute

```sh
EDITOR="<editor of your choice> --wait" rails credentials:edit
```
then save and edit the credentials file.

## Endpoints
<details>
 <summary><code>GET</code> <code>/api/v1/recipes</code></summary>


##### Parameters

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | country      |  required | string   | E.g. Thailand, Italy, etc.  |

##### Headers

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | Accept      |  required | string   | application/json  |
> | content-type      |  required | string   | application/json  |

##### Responses

> | http code     | content-type                      | response                                                            |
> |---------------|-----------------------------------|---------------------------------------------------------------------|
> | `200`         | `application/json`        | `{ "data": [{"id": null, "type": "recipe", "attributes": {"title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)", "url": "https://www.seriouseats.com/...", "country": "thailand", "image": "https://edamam-product-images.s3.amazonaws.com..."}}]`                                |

##### Example cURL

> ```javascript
>  curl -X GET -H "Accept: application/json content-type: application/json" "http://localhost:3000/api/v1/recipes?country=thailand"
> ```
</details>

<details>
 <summary><code>GET</code> <code>/api/v1/learning_resources</code></summary>


##### Parameters

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | country      |  required | string   | E.g. Thailand, Italy, etc.  |

##### Headers

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | Accept      |  required | string   | application/json  |
> | content-type      |  required | string   | application/json  |

##### Responses

> | http code     | content-type                      | response                                                            |
> |---------------|-----------------------------------|---------------------------------------------------------------------|
> | `200`         | `application/json`        | `{"data": {"id": null, "type": "learning_resource", "attributes": {"country": "laos", "video": {"title": "...", "youtube_video_id": "..."}, "images": [{"alt_tag": "...", "url": "..."}, ...]}}}`                               |

##### Example cURL

> ```javascript
>  curl -X GET -H "Accept: application/json content-type: application/json" "http://localhost:3000/api/v1/learning_resources?country=thailand"
> ```
</details>

<details>
 <summary><code>POST</code> <code>/api/v1/users</code></summary>

##### Parameters

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | none      |  N/A | N/A   | No parameters needed  |

##### Body

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | name      |  required | string   | E.g. "Odell"  |
> | email      |  required | string   | E.g. "your@name.com"  |
> | password      |  required | string   | E.g. "12345"  |
> | password_confirmation      |  required | string   | E.g. "12345"  |

##### Headers

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | Accept      |  required | string   | application/json  |
> | content-type      |  required | string   | application/json  |

##### Responses

> | http code     | content-type                      | response                                                            |
> |---------------|-----------------------------------|---------------------------------------------------------------------|
> | `201`         | `application/json`        | `{"data": {"type": "user", "id": "1", "attributes": {"name": "Odell", "email": "goodboy@ruffruff.com", "api_key": "jgn983hy48thw9begh98h4539h4"}}}`                               |
> | `400`         | `application/json`        | `{"data": {"error": [...]}}`                               |

##### Example cURL

> ```javascript
>  curl -X POST -H "Accept: application/json content-type: application/json" "http://localhost:3000/api/v1/users -d "<body of request here as json>""
> ```
</details>

<details>
 <summary><code>POST</code> <code>/api/v1/sessions</code></summary>


##### Parameters

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | email      |  required | string   | E.g. "your@name.com"  |
> | password      |  required | string   | E.g. "12345"  |

##### Headers

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | Accept      |  required | string   | application/json  |
> | content-type      |  required | string   | application/json  |

##### Responses

> | http code     | content-type                      | response                                                            |
> |---------------|-----------------------------------|---------------------------------------------------------------------|
> | `200`         | `application/json`        | `{"data": {"type": "user", "id": "1", "attributes": {"name": "Odell", "email": "goodboy@ruffruff.com", "api_key": "jgn983hy48thw9begh98h4539h4"}}}`                               |
> | `400`         | `application/json`        | `{"data": {"error": [...]}}`                               |

##### Example cURL

> ```javascript
>  curl -X POST -H "Accept: application/json content-type: application/json" "http://localhost:3000/api/v1/sessions -d "<body of request here as json>""
> ```
</details>

<details>
 <summary><code>POST</code> <code>/api/v1/favorites</code></summary>

##### Parameters

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | None      |  N/A | N/A   | Parameters not required.  |

##### Body

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | api_key      |  required | string   | E.g. "wjf390sj"  |
> | country      |  required | string   | E.g. "italy"  |
> | recipe_link      |  required | string   | E.g. "https://website.com/"  |
> | recipe_title      |  required | string   | E.g. "My Favorite Spaghetti Recipe"  |

##### Headers

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | Accept      |  required | string   | application/json  |
> | content-type      |  required | string   | application/json  |

##### Responses

> | http code     | content-type                      | response                                                            |
> |---------------|-----------------------------------|---------------------------------------------------------------------|
> | `200`         | `application/json`        | `{"data": {"type": "user", "id": "1", "attributes": {"name": "Odell", "email": "goodboy@ruffruff.com", "api_key": "jgn983hy48thw9begh98h4539h4"}}}`                               |
> | `400`         | `application/json`        | `{"data": {"error": [...]}}`                               |

##### Example cURL

> ```javascript
>  curl -X POST -H "Accept: application/json content-type: application/json" "http://localhost:3000/api/v1/favorites -d "<body of request here as json>"
> ```
</details>

<details>
 <summary><code>GET</code> <code>/api/v1/favorites</code></summary>


##### Parameters

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | api_key      |  required | string   | E.g. abc123  |

##### Headers

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | Accept      |  required | string   | application/json  |
> | content-type      |  required | string   | application/json  |

##### Responses

> | http code     | content-type                      | response                                                            |
> |---------------|-----------------------------------|---------------------------------------------------------------------|
> | `200`         | `application/json`        | `{"data": [{"id": "1", "type": "favorite", "attributes": {"recipe_title": "Recipe: Egyptian Tomato Soup", "recipe_link": "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....", "country": "egypt", "created_at": "2022-11-02T02:17:54.111Z"}}, ...]}`                               |
> | `401`         | `application/json`        | `{"error": ["Invalid API key"]}`                               |

##### Example cURL

> ```javascript
>  curl -X GET -H "Accept: application/json content-type: application/json" "http://localhost:3000/api/v1/favorites?api_key=abc123"
> ```
</details>