class CategoriesController < ApplicationController

    before_action :get_category, only: [:show, :edit, :update, :destroy]
    # Login required
    before_action :require_user, except: [:index, :show]
    before_action :require_admin, except: [:index, :show]

    def index
        @categories = Category.paginate(page: params[:page], per_page: 3)
    end

    def show
       
    end

    def new
        @category = Category.new
    end

    def edit
        
    end

    def create
        @category = Category.new(category_permas)
        if @category.save
            flash[:notice] = "Category added"
            redirect_to categories_path
        else
            render 'new'
        end
    end

    def update
        if @category.update(category_permas)
            flash[:notice] = "Category updated!"
            redirect_to @category
        else
            render 'edit'
        end
    end


    private

    def category_permas
        params.require(:category).permit(:name)
    end

    def get_category
        @category = Category.find(params[:id])
    end

    def require_admin
        if !(logged_in? && current_user.admin?)
            flash[:alert] = "You are not authorized to do this operation"
            redirect_to categories_path
        end
    end

end