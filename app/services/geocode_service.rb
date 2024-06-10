class GeocodeService
  def initialize(country)
    @country = country
  end

  def lat_lon
    conn = Faraday.new(url: "https://api.geoapify.com") do |faraday|
      faraday.headers["Content-Type"] = "application/json"
      faraday.headers["Accept"] = "application/json"
      faraday.params["apiKey"] =
        Rails.application.credentials.geoapify[:api_key]
      faraday.params["format"] = "json"
      faraday.params["country"] = @country
    end

    response = conn.get("/v1/geocode/search")
    json = JSON.parse(response.body, symbolize_names: true)

    lat = json[:results][0][:lat]
    lon = json[:results][0][:lon]

    [lat, lon]
  end

  def self.tourist_sites(lat_lon)
    lat = lat_lon[0]
    lon = lat_lon[1]

    conn = Faraday.new(url: "https://api.geoapify.com") do |faraday|
      faraday.headers["Content-Type"] = "application/json"
      faraday.headers["Accept"] = "application/json"
      faraday.params["apiKey"] =
        Rails.application.credentials.geoapify[:api_key]
      faraday.params["format"] = "json"
      faraday.params["categories"] = "tourism"
      faraday.params["filter"] = "circle:#{lon},#{lat},10000"
    end

    response = conn.get("/v2/places")
    json = JSON.parse(response.body, symbolize_names: true)
    json[:features]
  end
end
