class LearningResourcesFacade
  def initialize(country)
    @country = country
  end

  def learning_resources
    data = LearningResourcesService.new(@country).learning_resources
    LearningResource.new(data)
  end
end
