class SessionsController < ApplicationController
    def create
        user_info = request.env["omniauth.auth"]

        filter_email(params[:hd])

        user           = User.new
        user.id        = user_info["uid"]
        user.name      = user_info["info"]["name"]
        user.email     = user_info["info"]["email"]
        user.img = user_info["info"]["image"]
    
        session[:user] = Marshal.dump user

        redirect_to(root_path) and return
    end
    def destroy
        session.delete :user
        redirect_to root_path
    end

    def filter_email(domain)
        if domain != 'tamu.edu'
            redirect_to(root_path) and return
        end
    end
end
