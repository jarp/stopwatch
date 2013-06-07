class Developer < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password
  validates :email, :first_name, :last_name, :password, :presence => :true

  has_many :entries
  has_many :invoices, :dependent => :destroy

  has_many :projects, :through => :entries
  

  def to_s 
  	full_name
  end
  
  def full_name 
  	"#{first_name} #{last_name}"
  end

end
