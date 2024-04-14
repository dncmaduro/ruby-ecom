class UsersController < ApplicationController
  include UserParams

  def create
    @user_data = JSON.parse(request.body.read)
    @user = User.new(user_params)

    @user.email = @user_data["email"]
    @user.password = @user_data["password"]
    @user.name = @user_data["name"]
    @user.phone = @user_data["phone"]
    @user.address = @user_data["address"]
    @user.dob = @user_data["dob"]
    @user.role = 'CUSTOMER'

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])

    if @user.present?
      render json: @user, status: :ok
    else
      head :not_found
    end
  end

  def update
    @user = User.find(params[:id])

    token = session[:token]

    authorization_header = request.headers['Authorization']
    if authorization_header.present?
      header_token = authorization_header.split(' ').last
    end

    if @user.present?
      if token == header_token
        @user_data = JSON.parse(request.body.read)
        if @user_data.has_key?("phone")
          @user.phone = @user_data["phone"]
        end
        
        if @user_data.has_key?("address")
          @user.address = @user_data["address"]
        end
        
        if @user_data.has_key?("dob")
          @user.dob = @user_data["dob"]
        end

        if @user.save
          render json: @user, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      else
        head :unauthorized
      end
    else
      head :not_found
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: exception.message }, status: :not_found
  end
end
