class LearningResourcesService
  def initialize(country)
    @country = country
  end

  def learning_resources
    conn = Faraday.new(url: "https://www.googleapis.com") do |faraday|
      faraday.headers["Accept"] = "application/json"
      faraday.headers["Content-Type"] = "application/json"
      faraday.params["key"] = Rails.application.credentials.youtube[:api_key]
      faraday.params["part"] = "snippet"
      faraday.params["channelId"] = "UCluQ5yInbeAkkeCndNnUhpw"
      faraday.params["q"] = @country
    end

    response = conn.get("/youtube/v3/search")
    json = JSON.parse(response.body, symbolize_names: true)

    item = json[:items][0]

    conn = Faraday.new
  end
end
