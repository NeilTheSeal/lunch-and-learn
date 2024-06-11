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

    conn = Faraday.new(url: "https://api.pexels.com") do |faraday|
      faraday.headers["Authorization"] =
        Rails.application.credentials.pexels[:api_key]
      faraday.params["query"] = @country
    end

    response = conn.get("/v1/search")
    json = JSON.parse(response.body, symbolize_names: true)

    images = json[:photos].map do |photo|
      {
        alt_tag: photo[:alt],
        url: photo[:src][:original]
      }
    end

    {
      country: @country,
      video: {
        title: item[:snippet][:title],
        youtube_video_id: item[:id][:videoId]
      },
      images:
    }
  end
end
