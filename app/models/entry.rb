class Entry < ActiveRecord::Base
  belongs_to :developer
  belongs_to :project
  belongs_to :category
  
  attr_accessible :date, :description, :time, :project_id, :developer_id, :category_id

  validates :date, :description, :time, :presence => true
  validates :time, :numericality =>  :true
  

  validates_presence_of :developer_id
  validates_presence_of :project_id
  validates_presence_of :category_id

	#validate :date_is_legit
  after_initialize :default_values
  def default_values
    d = Time.new
    self.date ||= Time.new.strftime('%m/%d/%Y')
  end

  def date_is_legit

    errors.add(:date, "must be a valid date but was [#{date}]") 
    	if ( (Date.parse( date ) rescue ArgumentError) == ArgumentError)
  end
end
end
