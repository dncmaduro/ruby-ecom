class UsersController < ApplicationController
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

  private
    def user_params
      params.require(:user).permit(:email, :password, :name, :phone, :address, :dob, :role)
    end
end
