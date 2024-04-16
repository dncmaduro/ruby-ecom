class ItemsController < ApplicationController
    def create
        authorization_header = request.headers['Authorization']
        if authorization_header.present?
            header_token = authorization_header.split(' ').last
        end

        # Lấy user_id từ session
        user_id = session[:user_id]
        token = session[:token]

        shop_id = params[:shop_id]

        
        if token == header_token
            @user = User.find_by(id: user_id)
            @shop = Shop.find_by(id: shop_id)
            
            if  @user.present? && @user.role == 'MANAGER' && @shop.user_id == user_id
                @item_data = JSON.parse(request.body.read)
                @item = Item.new(item_params)
                
                @item.name = @item_data["name"]
                @item.description = @item_data["description"]
                @item.image = @item_data["image"]
                @item.price = @item_data["price"]
                @item.shop_id = shop_id
                puts(@shop)

                if @item.save
                    render json: @item, status: :created
                else
                    render json: @item.errors, status: :unprocessable_entity
                end
            end
        end
    end

    private
        def item_params
            params.require(:item).permit(:name, :description, :image, :price)
        end
end
