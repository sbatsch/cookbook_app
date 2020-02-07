class Api::RecipesController < ApplicationController

    def index
      search_term = params[:search]
      @recipes = Recipe.all

      if 
        @recipes = Recipe.all.where('title iLIKE ? OR ingredients iLIKE ?', "%#{ search_term }%", "%#{ search_term }%") 
      end 

      @recipes = Recipe.all.order(id: :asc)

      render 'index.json.jb'
    end

    def create
      @recipe = Recipe.new(
                          user_id: 2, #current_user.id,  
                          title: params[:title],
                          ingredients: params[:ingredients],
                          directions: params[:directions], 
                          prep_time: params[:prep_time],
                          image_url: params[:image_url]
                          )
      @recipe.save
      render 'show.json.jb'
    end 

    def show
        @recipe = Recipe.find(params[:id])
        render 'show.json.jb'
    end 

    def update 
      @recipe = Recipe.find(params[:id])

      @recipe.title = params[:title] || @recipe.title 
      @recipe.ingredients = params[:ingredients] || @recipe.ingredients
      @recipe.directions = params[:directions] || @recipe.directions
      @recipe.prep_time = params[:prep_time]  || @recipe.prep_time
      @recipe.image_url = params[:image_url]  || @recipe.image_url

      @recipe.save
      render 'show.json.jb'
    end

    def destroy
      recipe = Recipe.find(params[:id])
      recipe.destroy
      render json: {message: "Recipe successfully destroyed"}
    end
end
