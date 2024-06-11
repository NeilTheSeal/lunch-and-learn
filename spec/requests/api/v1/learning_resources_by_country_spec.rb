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
          Accept: "application/json"
        },
        params: {
          country: "italy"
        }
      )

      hash = JSON.parse(response.body, symbolize_names: true)
      data = hash[:data]

      expect(data[:id]).to eq(nil)
      expect(data[:type]).to eq("learning_resource")
      expect(data[:attributes]).to be_a(Hash)
      expect(data[:attributes][:country]).to eq("italy")
      expect(data[:attributes][:video][:title]).to be_a(String)
      expect(data[:attributes][:video][:youtube_video_id]).to be_a(String)
      expect(data[:attributes][:images]).to be_an(Array)
      expect(data[:attributes][:images].empty?).to eq(false)
    end
  end
end
