class Api::V1::RecipesController < ApplicationController
  def index
    facade = RecipeFacade.new(country_params[:country])
    render json: RecipeSerializer.new(facade.recipes)
  end

  private

  def country_params
    params.permit(:country)
  end
end
