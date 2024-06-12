require "rails_helper"

RSpec.describe Recipe do
  it "exists and has attributes" do
    recipe_data = {
      recipe: {
        label: "Chicken Parmesan",
        uri: "https://www.example.com/recipe/chicken-parmesan",
        image: "https://www.example.com/recipe/chicken-parmesan.jpg"
      }
    }

    recipe = Recipe.new(recipe_data, "Italy")

    expect(recipe).to be_a(Recipe)
    expect(recipe.title).to eq("Chicken Parmesan")
    expect(recipe.url).to eq("https://www.example.com/recipe/chicken-parmesan")
    expect(recipe.country).to eq("Italy")
    expect(recipe.image).to eq("https://www.example.com/recipe/chicken-parmesan.jpg")
  end
end
