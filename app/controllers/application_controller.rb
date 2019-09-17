require_relative '../../config/environment'
require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    return erb :error if !User.exists?(username: params[:username])
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id
    redirect '/account'
  end

  get '/account' do
    return erb :error if !session.keys.include?("user_id")
    # @user = User.find(session[:user_id])
    erb :account
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end
