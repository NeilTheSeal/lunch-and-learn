require "rails_helper"

# rubocop:disable Metrics/BlockLength
RSpec.describe "Favorites API", type: :request do
  before(:each) do
    @user = User.create!(
      email: "test@test.com",
      name: "test",
      password: "password",
      api_key: "123456"
    )
  end

  describe "POST /api/v1/favorites" do
    it "creates a favorite" do
      post(
        "/api/v1/favorites",
        params: {
          api_key: "123456",
          country: "thailand",
          recipe_link: "https://www.tastingtable.com/",
          recipe_title: "Thai Basil Chicken"
        }.to_json,
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }
      )

      expect(response).to have_http_status(:created)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to eq({
        success: "Favorite added successfully"
      })
    end

    it "returns an error if the api key is invalid" do
      post(
        "/api/v1/favorites",
        params: {
          api_key: "1234567",
          country: "thailand",
          recipe_link: "https://www.tastingtable.com/",
          recipe_title: "Thai Basil Chicken"
        }.to_json,
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }
      )

      expect(response).to have_http_status(:unauthorized)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:error)
      expect(body[:error]).to eq("Invalid API key")
    end

    it "returns an error if the country is missing" do
      post(
        "/api/v1/favorites",
        params: {
          api_key: "123456",
          recipe_link: "https://www.tastingtable.com/",
          recipe_title: "Thai Basil Chicken"
        }.to_json,
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }
      )

      expect(response).to have_http_status(:unprocessable_entity)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:error)
      expect(body[:error]).to eq("Country can't be blank")
    end

    it "returns an error if the recipe link is missing" do
      post(
        "/api/v1/favorites",
        params: {
          api_key: "123456",
          country: "thailand",
          recipe_title: "Thai Basil Chicken"
        }.to_json,
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }
      )

      expect(response).to have_http_status(:unprocessable_entity)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:error)
      expect(body[:error]).to eq("Recipe link can't be blank")
    end

    it "returns an error if the recipe title is missing" do
      post(
        "/api/v1/favorites",
        params: {
          api_key: "123456",
          country: "thailand",
          recipe_link: "https://www.tastingtable.com/"
        }.to_json,
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }
      )

      expect(response).to have_http_status(:unprocessable_entity)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:error)
      expect(body[:error]).to eq("Recipe title can't be blank")
    end
  end

  describe "GET /api/v1/favorites" do
    before(:each) do
      @favorite1 = Favorite.create!(
        country: "thailand",
        recipe_link: "https://www.tastingtable.com/",
        recipe_title: "Thai Basil Chicken",
        user: @user
      )

      @favorite2 = Favorite.create!(
        country: "japan",
        recipe_link: "https://www.justonecookbook.com/",
        recipe_title: "Teriyaki Chicken",
        user: @user
      )
    end

    it "returns a list of favorites" do
      get(
        "/api/v1/favorites",
        params: {
          api_key: "123456"
        },
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }
      )

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data]).to be_an(Array)

      data = body[:data]

      expect(data.length).to eq(2)

      favorite = data.first

      expect(favorite[:id]).to eq(@favorite1.id.to_s)
      expect(favorite[:type]).to eq("favorite")
      expect(favorite[:attributes][:country]).to eq("thailand")
      expect(favorite[:attributes][:recipe_link]).to eq("https://www.tastingtable.com/")
      expect(favorite[:attributes][:recipe_title]).to eq("Thai Basil Chicken")
    end

    it "returns an error if the api key is invalid" do
      get(
        "/api/v1/favorites",
        params: {
          api_key: "1234567"
        },
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }
      )

      expect(response).to have_http_status(:unauthorized)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:error)
      expect(body[:error]).to eq("Invalid API key")
    end

    it "returns an empty list if the user has no favorites" do
      @user.favorites.destroy_all

      get(
        "/api/v1/favorites",
        params: {
          api_key: "123456"
        },
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }
      )

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data]).to be_an(Array)
      expect(body[:data].length).to eq(0)
    end
  end
end
# rubocop:enable Metrics/BlockLength
