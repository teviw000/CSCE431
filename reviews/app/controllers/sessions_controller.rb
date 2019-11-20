class SessionsController < ApplicationController
    def create
        user_info = request.env["omniauth.auth"]

        user           = User.new
        user.id        = user_info["uid"]
        user.name      = user_info["name"]
        user.email     = user_info["email"]
        # user.image_url = user_info["info"]["image"]
    
        session[:user] = Marshal.dump user
    
        redirect_to root_path
    end
    def destroy
        session.delete :user
        redirect_to root_path
    end
end
