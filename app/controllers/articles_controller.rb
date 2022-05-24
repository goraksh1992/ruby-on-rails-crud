class ArticlesController < ApplicationController

    def index
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        @article = Article.new(
            params.require(:article).permit(:title, :description)
        )

        if @article.save
            flash[:notice] = "New article added!"
            redirect_to articles_path
        else
            redirect_to 'new'
        end
    end


    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "New article updated!"
            redirect_to articles_path
        else
            redirect_to 'new'
        end
    end


    def destroy
        @article = Article.find(params[:id])
        @article.destroy

        redirect_to articles_path
    end

end