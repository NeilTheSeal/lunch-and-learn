class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if !user.nil? && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UserSerializer.new(user), status: :created
    else
      render json: {
        errors: "Sorry, your credentials are bad."
      }, status: :bad_request
    end
  end
end
