require "rails_helper"

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
          recipe_name: "Thai Basil Chicken"
        },
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
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
          recipe_name: "Thai Basil Chicken"
        },
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        }
      )

      expect(response).to have_http_status(:unauthorized)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:error)
      expect(body[:error]).to eq("Invalid API key")
    end
  end
end
