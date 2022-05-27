class UsersController < ApplicationController 

    before_action :get_user, only: [:show, :edit, :update, :destroy]
    # This is for login required validation
    before_action :require_user, except: [:index, :show, :new]
    # Only user update and delete the article which he added
    before_action :require_same_user, only: [:edit, :update, :destory]

    def index
        @users = User.paginate(page: params[:page], per_page: 4)
    end

    def show
    end

    def new
        @user = User.new
    end

    def edit
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "Welcome..! Account created!"
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "Account updated"
            redirect_to @user
        else
            render 'edit'
        end
    end


    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :profile_image)
    end

    def get_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user
            flash[:alert] = "You don't have permission to do this operation"
            redirect_to article_path
        end
    end

end