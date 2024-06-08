require "rails_helper"

# rubocop:disable Metrics/BlockLength
RSpec.describe "Recipes by Country" do
  it "happy path - retrieve recipes for a country" do
    VCR.use_cassette(
      "search_by_country",
      serialize_with: :json
    ) do |cassette|
      get(
        "/api/v1/recipes",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        params: {
          country: "italy"
        }
      )

      body = JSON.parse(
        cassette.serializable_hash.dig(
          "http_interactions", 0, "response", "body", "string"
        ),
        symbolize_names: true
      )

      expect(body).to have_key(:data)
      data = body[:data]

      expect(data).to be_an(Array)
      expect(data.length > 1).to eq(true)
      expect(data.first[:id]).to eq(nil)
      expect(data.first[:type]).to eq("recipe")
      expect(data.first[:attributes]).to be_a(Hash)
      expect(data.first[:attributes[:title]]).to be_a(String)
      expect(data.first[:attributes][:url]).to be_a(String)
      expect(data.first[:attributes][:country]).to be_a(String)
      expect(data.first[:attributes][:image]).to be_a(String)

      not_have_key = %i[
        from to count _links hits recipe
        uri label images source shareAs mealType
        yield dietLabels healthLabels cautions
        ingredientLines ingredients calories totalCO2Emissions
        co2EmissionsClass totalWeight totalTime cuisineType
        dishType totalNutrients totalDaily digest
      ]

      not_have_key.each do |key|
        expect(data.first[:attributes]).to_not have_key(key)
      end
    end
  end

  it "happy path - no country provided" do
    VCR.use_cassette(
      "no_country_provided",
      serialize_with: :json
    ) do |cassette|
      get(
        "/api/v1/recipes",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        }
      )

      body = JSON.parse(
        cassette.serializable_hash.dig(
          "http_interactions", 0, "response", "body", "string"
        ),
        symbolize_names: true
      )

      expect(body).to have_key(:data)
      data = body[:data]

      expect(data).to be_an(Array)
      expect(data.length > 1).to eq(true)
      expect(data.first[:id]).to eq(nil)
      expect(data.first[:type]).to eq("recipe")
      expect(data.first[:attributes]).to be_a(Hash)
      expect(data.first[:attributes[:title]]).to be_a(String)
      expect(data.first[:attributes][:url]).to be_a(String)
      expect(data.first[:attributes][:country]).to be_a(String)
      expect(data.first[:attributes][:image]).to be_a(String)
    end
  end

  it "sad path - empty string provided" do
    VCR.use_cassette(
      "empty_country_string_provided",
      serialize_with: :json
    ) do |cassette|
      get(
        "/api/v1/recipes",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        params: {
          country: ""
        }
      )

      body = JSON.parse(
        cassette.serializable_hash.dig(
          "http_interactions", 0, "response", "body", "string"
        ),
        symbolize_names: true
      )

      expect(body[:data]).to eq([])
    end
  end

  it "sad path - invalid country provided" do
    VCR.use_cassette(
      "invalid_country_provided",
      serialize_with: :json
    ) do |cassette|
      get(
        "/api/v1/recipes",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        params: {
          country: "invalid_country"
        }
      )

      body = JSON.parse(
        cassette.serializable_hash.dig(
          "http_interactions", 0, "response", "body", "string"
        ),
        symbolize_names: true
      )

      expect(body[:data]).to eq([])
    end
  end
end
# rubocop:enable Metrics/BlockLength
