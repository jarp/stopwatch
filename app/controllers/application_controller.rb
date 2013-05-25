class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout 'internal'
  		

  def require_login
  	unless session.has_key? :user
  		flash[:error] = "You are not logged in, friendo"
  		redirect_to login_path
  	end		
  end

end
