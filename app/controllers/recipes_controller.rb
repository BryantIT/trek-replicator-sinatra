class RecipesController < ApplicationController

  get "/recipes" do
    @recipes = Recipe.all
    erb :"recipes/index"
  end

  get "/recipes/new" do
    @users = User.all
    erb :"recipes/new"
  end

  get "/recipes/:id" do
    id = params[:id]
    @recipe = Recipe.find_by_id(:id)
    erb :"recipes/show"
  end

  post "/recipes" do
    recipe = Recipe.new(params)
    if recipe.save
      redirect "recipes/#{recipe.id}"
    else
      redirect "recipes/new"
    end

  end


end
