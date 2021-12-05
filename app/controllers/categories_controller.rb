class CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :get_user, only: %i[ index show new edit create update destroy ]
    before_action :set_category, only: %i[ show edit update destroy ]
    
    def index
        @categories = @user.categories
    end

    def show
        @tasks = @category.tasks
    end

    def new
        @category = @user.categories.build
    end

    def create
        @category = @user.categories.build(category_params)

        if @category.save
            redirect_to categories_path
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @category.update(category_params)
            redirect_to categories_path
        else
            render :edit
        end
    end

    def destroy
        @category.destroy
        redirect_to categories_path
    end

    private
    def get_user
        @user = User.find(current_user.id)
    end

    def set_category
        @category = Category.find(params[:id])
    end
    
    def category_params
        params.require(:category).permit(:name, :user_id)
    end
end
