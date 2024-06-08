class RecipeFacade
  def initialize(country)
    @country = country
  end

  def recipes
    if @country.nil?
      RecipeService.new(nil).random_country_recipes
    elsif @country == ""
      []
    else
      RecipeService.new(@country).recipes
    end
  end
end
