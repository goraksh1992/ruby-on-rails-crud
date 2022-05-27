class ArticlesController < ApplicationController

    before_action :get_article, only: [:show, :edit, :update, :destroy]
    # This is for login required validation
    before_action :require_user, except: [:index, :show]
    # Only user update and delete the article which he added
    before_action :require_same_user, only: [:edit, :update, :destory]

    def index
        @articles = Article.paginate(page: params[:page], per_page: 4)
    end

    def show
    end

    def new
        @article = Article.new
    end

    def edit
    end

    def create
        @article = Article.new(
            article_params
        )
        @article.user = current_user

        if @article.save
            flash[:notice] = "New article added!"
            redirect_to articles_path
        else
            render 'new'
        end
    end


    def update
        if @article.update(article_params)
            flash[:notice] = "New article updated!"
            redirect_to articles_path
        else
            render 'edit'
        end
    end


    def destroy
        @article.destroy
        redirect_to articles_path
    end

    private

    def get_article
        @article = Article.find(params[:id])
    end 

    def article_params
        params.require(:article).permit(:title, :description)
    end

    def require_same_user
        if current_user != @article.user
            flash[:alert] = "You dont have permission to do this operation!"
            redirect_to @article
        end
    end

end