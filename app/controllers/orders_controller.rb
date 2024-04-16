class OrdersController < ApplicationController
    def create
        authorization_header = request.headers['Authorization']
        if authorization_header.present?
            header_token = authorization_header.split(' ').last
        end

        user_id = session[:user_id]
        token = session[:token]

        if token == header_token
            @user = User.find_by(id: user_id)
            if @user.present?
                @data = JSON.parse(request.body.read)
                @order_data = @data["order"]
                @order = Order.new()

                @order.status = 'UNPAID'
                @order.user_id = user_id

                @items = @order_data["items"]
                price = 0
                @items.each do |item|
                    item_id = item["item_id"]
                    @item = Item.find_by(id: item_id)
                    price += @item[:price].to_f * item["quantity"].to_i
                    puts(item["price"], item["quantity"])
                end

                @order.price = price

                if @order.save
                    @items.each do |item|
                        @orders_item = OrdersItem.new()
                        @orders_item.order_id = @order.id
                        @orders_item.item_id = item["item_id"]
                        @orders_item.quantity = item["quantity"]
                        @orders_item.save
                    end
                    
                    render json: @order, status: :created
                else
                    render json: @order.errors, status: :unprocessable_entity
                end
            end
        end
    end
end
