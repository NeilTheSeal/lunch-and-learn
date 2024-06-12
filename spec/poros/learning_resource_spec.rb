require "rails_helper"

RSpec.describe LearningResource do
  it "exists and has attributes" do
    learning_resource_data = {
      video: {
        title: "Italian Cooking",
        youtube_video_id: "12345"
      },
      country: "Italy",
      images: [
        {
          alt_tag: "Italian Cooking",
          url: "https://www.example.com/italian-cooking.jpg"
        }
      ]
    }

    learning_resource = LearningResource.new(learning_resource_data)

    expect(learning_resource).to be_a(LearningResource)
    expect(learning_resource.video).to eq(learning_resource_data[:video])
    expect(learning_resource.country).to eq("Italy")
    expect(learning_resource.images).to be_an(Array)
    expect(learning_resource.images.first).to be_a(Hash)
    expect(learning_resource.images.first[:alt_tag]).to eq("Italian Cooking")
    expect(learning_resource.images.first[:url]).to eq("https://www.example.com/italian-cooking.jpg")
  end
end
