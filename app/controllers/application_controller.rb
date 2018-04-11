require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    #your code here

    user = User.new(:username => params[:username], :password => params[:password], :balance => params[:balance])

    if user.username == ""
      redirect "/failure"
    elsif user.save
      redirect "/login"
    else
      redirect "/failure"
    end
  end

  # get '/account' do
  #   if current_user && logged_in?
  #   # user = User.find(session[:user_id])
  #     erb :account
  #   end
  # end

  get '/account' do
    if logged_in? && current_user.balance > params[:amount].to_f
      @user = current_user

      current_user.update(balance: current_user.balance - params[:amount].to_f)

    # redirect "/account"
    # if logged_in?
      # @user = current_user
      erb :account
    else
      redirect "/failure"
    end
  end


  get "/login" do
    erb :login
  end

  post "/login" do
    #your code here
    user = User.find_by(:username => params[:username])

     if user && user.authenticate(params[:password])
         session[:user_id] = user.id
         redirect "/account"
     else
         redirect "/failure"
     end
   end

   get "/deposit" do
     erb :deposit
   end

   get "/withdrawal" do
     erb :withdrawal
   end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def validate
      errors.add(:balance, "should be at least 0.00") if price.nil? || price < 0.00
    end
  end

end
