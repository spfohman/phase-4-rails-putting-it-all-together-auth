class RecipesController < ApplicationController

    def index
            recipes = Recipe.all 
            render json: recipes, status: :ok 
        
    end

    def create 
        user = User.find_by(id: session[:user_id]) 
        if user.valid?
            recipe = user.recipes.create!(recipe_params)
            render json: recipe, status: :created 
        else
            render json: {errors: ["Unauthorized"]}, status: :unprocessable_entity 
        end
    end

    private 
    def recipe_params 
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
