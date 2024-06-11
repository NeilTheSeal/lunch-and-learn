class Api::V1::LearningResourcesController < ApplicationController
  def index
    facade = LearningResourcesFacade.new(learning_resources_params[:country])
    render json: LearningResourceSerializer.new(facade.learning_resources)
  end

  private

  def learning_resources_params
    params.permit(:country)
  end
end
