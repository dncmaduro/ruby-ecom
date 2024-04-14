module UserParams
    def user_params
        params.require(:user).permit(:email, :password, :name, :phone, :address, :dob, :role)
    end
end