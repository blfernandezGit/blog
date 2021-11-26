class CommentsController < ApplicationController
    before_action :get_article

    def index
        @comments = @article.comments
    end
    
    def new
        @comment = @article.comments.build
    end
    
    def create
        @comment = @article.comments.build(comment_params)
    
        if @comment.save
            redirect_to show_article_path(@article)
        else
            render :new
        end
    end
    
    private
    
    def get_article
        @article = Article.find(params[:article_id])
    end
    
    def comment_params
        params.require(:comment).permit(:body, :article_id)
    end 

end
