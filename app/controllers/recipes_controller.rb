class RecipesController < ApplicationController

  get "/recipes" do
    if logged_in?
      @recipes = current_user.recipes.all
      erb :"recipes/index"
    else
      erb :"/sessions/error"
    end
  end

  get "/recipes/new" do
    @users = User.all
    erb :"recipes/new"
  end

  post "/recipes" do
    @recipe = current_user.recipes.build(name: params[:name], ingredients: params[:ingredients], directions: params[:directions], notes: params[:notes])
    if @recipe.save
      redirect "/recipes/#{@recipe.id}"
    else
      redirect "/recipes/new"
    end
  end

  get "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe.user_id == current_user.id
    erb :"recipes/show"
    else
    redirect "/recipes"
    end
  end

  get "/recipes/:id/edit" do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe.user_id == current_user.id
      erb :"recipes/edit"
    else
      redirect "/recipes"
  end
end

  patch "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    params.delete("_method")
    if @recipe.user.id == current_user.id && @recipe.update(name: params[:name], ingredients: params[:ingredients], directions: params[:directions], notes: params[:notes], user_id: current_user.id)
      redirect "/recipes/#{@recipe.id}"
    else
      redirect "/recipes/#{@recipe.id}/edit"
    end
  end

 delete "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe.user.id == current_user.id
      @recipe.destroy
      redirect "/recipes"
    else
      redirect "/recipes"
    end
  end
end
