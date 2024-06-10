require "rails_helper"

RSpec.describe TouristSite do
  before(:each) do
    VCR.use_cassette("tourist_sites_poro", serialize_with: :json) do
      @tourist_sites = GeocodeService.tourist_sites([48.8566, 2.3522])
      @tourist_site = TouristSite.new(@tourist_sites[0])
    end
  end

  it "has attributes" do
    expect(@tourist_site).to be_a(TouristSite)
    expect(@tourist_site.id).to eq(nil)
    expect(@tourist_site.name).to be_a(String)
    expect(@tourist_site.address).to be_a(String)
    expect(@tourist_site.place_id).to be_a(String)
  end
end
