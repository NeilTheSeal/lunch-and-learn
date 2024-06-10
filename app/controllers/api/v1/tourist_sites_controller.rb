class Api::V1::TouristSitesController < ApplicationController
  def index
    facade = TouristSitesFacade.new(country_params[:country])
    render json: TouristSiteSerializer.new(facade.tourist_sites)
  end

  private

  def country_params
    params.permit(:country)
  end
end
