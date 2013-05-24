class HomeController < ApplicationController
  def index
  	@entry = Entry.new
  end

  def login
  end

  def authenticate
  end

  def logout
  end
end
