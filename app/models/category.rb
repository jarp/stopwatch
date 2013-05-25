class Category < ActiveRecord::Base
  attr_accessible :code, :name, :rate
  validates :name, :code, :presence => :true

  def to_s 
  	"#{name}"
  end
  
end
