require "rails_helper"

RSpec.describe "Learning Resources by Country" do
  it "happy path - retrieve learning resources for a country" do
    VCR.use_cassette(
      "learning_resources_by_country",
      serialize_with: :json
    ) do
      get(
        "/api/v1/learning_resources",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        params: {
          country: "italy"
        }
      )

      data = JSON.parse(response.body, symbolize_names: true)

      require "pry"
      binding.pry
    end
  end
end
