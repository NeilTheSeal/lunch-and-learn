require "rails_helper"

RSpec.describe RecipeFacade do
  it "happy path - returns recipes for a specific country" do
    VCR.use_cassette("recipe_facade#recipes") do
      recipes = RecipeFacade.new("Italy").recipes

      expect(recipes.count > 0).to eq(true)
      expect(recipes.first).to be_a(Recipe)
    end
  end

  # xit because VCR will use a new cassette for each test
  xit "sad path - returns random recipes when country is nil" do
    VCR.use_cassette("recipe_facade#random_country_recipes") do
      recipes = RecipeFacade.new(nil).recipes

      expect(recipes.count > 0).to eq(true)
      expect(recipes.first).to be_a(Recipe)
    end
  end

  it "sad path - returns empty array when country is empty string" do
    recipes = RecipeFacade.new("").recipes

    expect(recipes).to eq([])
  end
end
