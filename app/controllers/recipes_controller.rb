class RecipesController < ApplicationController

  get "/recipes" do
    if logged_in?
      @recipes = Recipe.all
      erb :"recipes/index"
    else
      redirect "/login"
    end
  end

  get "/recipes/new" do
    @users = User.all
    erb :"recipes/new"
  end

  get "/recipes/:id/edit" do
    @users = User.all
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe.user.id == current_user.id
      erb :"recipes/edit"
    else
      redirect "/recipes"
  end

  patch "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    params.delete("_method")
    if @recipe.update(params)
      redirect "/recipes/#{@recipe.id}"
    else
      redirect "/recipes/#{@recipe.id}/edit"
    end
  end

  get "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    erb :"recipes/show"
  end

  post "/recipes" do
    recipe = Recipe.new(params)
    if recipe.save
      redirect "/recipes/#{recipe.id}"
    else
      redirect "/recipes/new"
    end
  end

  delete "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect "/recipes"
  end
end
