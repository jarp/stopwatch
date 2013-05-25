class HomeController < ApplicationController
 
  #before_filter :require_login, :except => [:login, :authenticate]

  def index
  	@entry = Entry.new
  end

  def login
  end

  def authenticate

  	dev = Developer.find_by_email_and_password(params[:email], params[:password])

  	unless dev.nil?

  		session[:user] = {
  			:id => dev.id,
  			:email => dev.email,
  			:name => dev.first_name
  			}	
  		
  			flash[:message] = "Welcome back #{dev.first_name}! You have been logged in" 
  			redirect_to home_path	
  		
  		else
  			flash[:error] = "You are a loser. You can't even login correctly..."
  			session[:user] = nil
  			redirect_to login_path
  		end

  end

  def logout
  	  flash[:message] = "Goodbye #{session[:name]}! You have been logged out. We'll miss you :-(" 
  	  session[:user] = nil
  	  redirect_to login_path
  end
end
