class Project < ActiveRecord::Base
  attr_accessible :name, :description
  validates :name, :presence => :true
  has_many :invoices, :dependent => :destroy

    def to_s 
  	"#{name}"
  end
end
