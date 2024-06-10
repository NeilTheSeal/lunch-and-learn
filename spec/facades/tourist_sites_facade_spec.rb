require "rails_helper"

RSpec.describe TouristSitesFacade do
  describe "instance methods" do
    describe "#tourist_sites" do
      it "returns an array of TouristSite objects" do
        VCR.use_cassette("tourist_sites_facade", serialize_with: :json) do
          facade = TouristSitesFacade.new("France")

          expect(facade.tourist_sites).to be_an(Array)
          expect(facade.tourist_sites.first).to be_a(TouristSite)
        end
      end
    end
  end
end
