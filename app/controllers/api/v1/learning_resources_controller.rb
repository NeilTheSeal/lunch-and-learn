class Api::V1::LearningResourcesController < ApplicationController
  def index
    facade = LearningResourcesFacade.new(learning_resources_params[:country])
    facade.learning_resources
    # render json: LearningResourcesSerializer.new(facade.learning_resources)
  end

  private

  def learning_resources_params
    params.permit(:country)
  end
end
