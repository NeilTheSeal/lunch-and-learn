class Recipe
  attr_reader :id, :title, :url, :image, :country

  def initialize(hit, country)
    @id = nil
    @title = hit[:recipe][:label]
    @url = hit[:recipe][:uri]
    @image = hit[:recipe][:image]
    @country = country
  end
end
