require "rails_helper"

RSpec.describe LearningResourcesService do
  it "returns learning resources for a specific topic" do
    VCR.use_cassette("learning_resource_service#learning_resources") do
      service = LearningResourcesService.new("Italy")
      learning_resources = service.learning_resources

      expect(learning_resources).to be_a(Hash)
      expect(learning_resources[:video]).to be_a(Hash)
      expect(learning_resources[:video][:title]).to be_a(String)
      expect(learning_resources[:video][:youtube_video_id]).to be_a(String)

      expect(learning_resources[:country]).to eq("Italy")
      expect(learning_resources[:images]).to be_an(Array)
      expect(learning_resources[:images].first).to be_a(Hash)
      expect(learning_resources[:images].first[:alt_tag]).to be_a(String)
      expect(learning_resources[:images].first[:url]).to be_a(String)
    end
  end
end
