class AdminController < ApplicationController
    include UserParams

    def create
        @user_data = JSON.parse(request.body.read)
        key = @user_data["admin_key"]
        
        @user = User.new()
        
        @user.email = @user_data["email"]
        @user.password = @user_data["password"]
        @user.name = @user_data["name"]
        @user.phone = @user_data["phone"]
        @user.address = @user_data["address"]
        @user.dob = @user_data["dob"]
        @user.role = 'MANAGER'
        
        if key == ENV["ADMIN_KEY"]
            if @user.save
                render json: @user, status: :created
            else
                render json: @user.errors, status: :unprocessable_entity
            end
        else
            head :unauthorized
        end
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: { error: exception.message }, status: :not_found
    end
end
