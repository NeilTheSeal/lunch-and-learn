class LearningResource
  attr_reader :id, :country, :video, :images

  def initialize(item, country, images)
    @id = nil
    @country = country
    @video = {
      title: item[:snippet][:title],
      youtube_video_id: item[:id][:videoId]
    }
    @images = map_images(images)
  end

  private

  def map_images(images)
    images.map do |image|
      {
        alt_tag: image[:alt],
        url: image[:url]
      }
    end
  end
end
