require "rails_helper"

# rubocop:disable Metrics/BlockLength
RSpec.describe "Tourist Sites by Country" do
  it "happy path - can give the tourist sites near a country's location" do
    VCR.use_cassette(
      "tourist_sites_by_country",
      serialize_with: :json
    ) do
      get(
        "/api/v1/tourist_sites",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        params: {
          country: "France"
        }
      )

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data).to be_an(Array)
      expect(data.length > 1).to eq(true)
      expect(data.first[:id]).to eq(nil)
      expect(data.first[:type]).to eq("tourist_site")
      expect(data.first[:attributes]).to be_a(Hash)
      expect(data.first[:attributes][:name]).to be_a(String)
      expect(data.first[:attributes][:address]).to be_a(String)
      expect(data.first[:attributes][:place_id]).to be_a(String)
    end
  end
end
# rubocop:enable Metrics/BlockLength
