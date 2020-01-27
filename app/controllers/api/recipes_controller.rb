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
                          title: params[:title],
                          chef: params[:chef],
                          ingredients: params[:ingredients],
                          directions: params[:directions], 
                          prep_time: params[:prep_time]
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
      @recipe.chef = params[:chef] || @recipe.chef
      @recipe.ingredients = params[:ingredients] || @recipe.ingredients
      @recipe.directions = params[:directions] || @recipe.directions
      @recipe.prep_time = params[:prep_time]  || @recipe.prep_time

      @recipe.save
      render 'show.json.jb'
    end

    def destroy
      recipe = Recipe.find(params[:id])
      recipe.destroy
      render json: {message: "Recipe successfully destroyed"}
    end
end
