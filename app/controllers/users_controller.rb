class UsersController < ApplicationController
  get '/users/register' do
    erb :'/users/register'
  end

  post '/users' do
    @user = User.new(username: params[:username], password: params[:password] )
    if @user.save
      session[:user_id] = @user.id
      redirect '/recipes'
    else
      redirect '/users/register'
    end
  end
end
