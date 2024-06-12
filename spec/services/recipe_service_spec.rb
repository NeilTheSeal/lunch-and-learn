require "rails_helper"

RSpec.describe RecipeService do
  it "returns recipes for a specific country" do
    VCR.use_cassette("recipe_service#recipes") do
      service = RecipeService.new("Italy")
      recipes = service.recipes

      expect(recipes.count).to eq(20)
      expect(recipes.first).to be_a(Recipe)
    end
  end
end
