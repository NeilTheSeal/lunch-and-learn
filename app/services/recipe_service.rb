class RecipeService
  def initialize(country)
    @country = country
  end

  def recipes
    conn = Faraday.new(url: "https://api.edamam.com") do |faraday|
      faraday.headers["Accept"] = "application/json"
      faraday.headers["Content-Type"] = "application/json"
      faraday.params["app_id"] =
        Rails.application.credentials.edamam_recipe_api[:id]
      faraday.params["app_key"] =
        Rails.application.credentials.edamam_recipe_api[:api_key]
      faraday.params["type"] = "public"
      faraday.params["q"] = @country
    end

    response = conn.get("/api/recipes/v2")
    json = JSON.parse(response.body, symbolize_names: true)

    hits = json[:hits]
    hits.map do |hit|
      Recipe.new(hit, @country)
    end
  end

  def random_country_recipes
    # This API is extremely slow, so I used a fixture file. Here is the code
    # that would be used if we were to use the API:

    # conn = Faraday.new(url: "https://restcountries.com") do |faraday|
    #   faraday.headers["Accept"] = "application/json"
    # end

    # response = conn.get("/v3.1/all")
    # json = JSON.parse(response.body, symbolize_names: true)

    json = JSON.parse(File.read("public/countries.json"), symbolize_names: true)
    @country = json.sample[:name][:common]

    recipes
  end
end
