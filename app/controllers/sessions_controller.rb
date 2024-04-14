class SessionsController < ApplicationController
    def login
        @user_data = JSON.parse(request.body.read)

        user = User.find_by(email: @user_data["email"])
        if user && user.authenticate(@user_data["password"])
            # Mã hóa mật khẩu
            hashed_password = BCrypt::Password.create(@user_data["password"])

            # Tạo token xác thực
            token = SecureRandom.hex(64)

            # Lưu trữ thông tin vào session
            session[:user_id] = user.id
            session[:token] = token

            # Tạo response JSON
            response_json = {
                message: 'Login successful',
                token: token
            }

            render json: response_json, status: :ok
        else
            render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
    end

    def logout
        session.delete(:user_id)
        render json: { message: 'Logout successful' }, status: :ok
    end
end
  