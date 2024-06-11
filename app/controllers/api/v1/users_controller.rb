class Api::V1::UsersController < ApplicationController
  def create
    name = params[:name].downcase
    email = params[:email]
    password = params[:password]
    password_confirmation = params[:password_confirmation]

    user = User.new(
      name:,
      email:,
      password:,
      password_confirmation:,
      api_key: SecureRandom.hex(13)
    )

    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: { errors: user.errors.full_messages.to_sentence },
             status: :bad_request
    end
  end
end
