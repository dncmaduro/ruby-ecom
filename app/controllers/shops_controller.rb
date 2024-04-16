class ShopsController < ApplicationController
    def create
        authorization_header = request.headers['Authorization']
        if authorization_header.present?
            header_token = authorization_header.split(' ').last
        end

        # Lấy user_id từ session
        user_id = session[:user_id]
        token = session[:token]

        if token == header_token
            @user = User.find_by(user_id)
            @current_shop = Shop.find_by(user_id)
            if @user.present? && @user.role == 'MANAGER' && !@current_shop.present?
                @shop_data = JSON.parse(request.body.read)
                @shop = Shop.new(shop_params)

                @shop.name = @shop_data["name"]
                @shop.address = @shop_data["address"]
                @shop.cover = @shop_data["cover"]
                @shop.description = @shop_data["description"]
                @shop.user_id = user_id

                if @shop.save
                    render json: @shop, status: :created
                else
                    render json: @shop.errors, status: :unprocessable_entity
                end
            end
        end
    end

    private
        def shop_params
            params.require(:shop).permit(:name, :description, :address, :cover)
        end
end
