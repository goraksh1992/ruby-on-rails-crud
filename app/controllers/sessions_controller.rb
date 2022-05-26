class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] = "Welcome #{user.username}"
            redirect_to user
        else
            flash.now[:alert] = "Invalid login credentials"
            render 'new'
        end
    end

    def destroy
        flash[:notice] = "Logout successfully!"
        session[:user_id] = nil
        redirect_to root_path
    end
end