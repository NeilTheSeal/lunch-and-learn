class TouristSitesFacade
  def initialize(country)
    @country = country
  end

  def tourist_sites
    lat_lon = GeocodeService.new(@country).lat_lon
    tourist_sites = GeocodeService.tourist_sites(lat_lon)
    tourist_sites.map do |site|
      TouristSite.new(site)
    end
  end
end
