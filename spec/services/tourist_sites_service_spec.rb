require "rails_helper"

# rubocop:disable Metrics/BlockLength
RSpec.describe GeocodeService do
  describe "class methods" do
    describe ".tourist_sites" do
      it "returns an array of tourist sites" do
        VCR.use_cassette(
          "tourist_sites_service_tourist_sites",
          serialize_with: :json
        ) do
          tourist_sites = GeocodeService.tourist_sites([48.8566, 2.3522])

          expect(tourist_sites).to be_an(Array)
          expect(tourist_sites.first).to be_a(Hash)
          expect(tourist_sites.first).to have_key(:properties)
          expect(tourist_sites.first[:properties]).to have_key(:name)
          expect(tourist_sites.first[:properties]).to have_key(:formatted)
          expect(tourist_sites.first[:properties]).to have_key(:place_id)
        end
      end
    end
  end

  describe "instance methods" do
    describe "#lat_lon" do
      it "returns an array with lat and lon" do
        VCR.use_cassette(
          "tourist_sites_service_lat_lon",
          serialize_with: :json
        ) do
          geocode_service = GeocodeService.new("France")
          lat_lon = geocode_service.lat_lon

          expect(lat_lon).to be_an(Array)
          expect(lat_lon.first).to be_a(Float)
          expect(lat_lon.last).to be_a(Float)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
