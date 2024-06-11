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

  def login
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.username}"
      if user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to root_path
      end
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
