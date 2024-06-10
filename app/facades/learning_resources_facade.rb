class LearningResourcesFacade
  def initialize(country)
    @country = country
  end

  def learning_resources
    LearningResourcesService.new(@country).learning_resources
  end
end
