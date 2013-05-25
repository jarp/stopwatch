class Entry < ActiveRecord::Base


  belongs_to :developer
  belongs_to :project
  belongs_to :category
  
  attr_accessible :date, :description, :time,  :hours, :project_id, :developer_id, :category_id

  validates :date, :description, :hours, :presence => true
  #validates :time, :numericality =>  :true
  

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

  def payment
    ratio * category.rate
  end

  def ratio
    
    break_up = self.hours.split(' ')

    if break_up.count == 2
      h =  break_up[0].sub('h', '').to_i
      m =  break_up[1].sub('m', '').to_i
    elsif break_up[0].index('h') 
      h = break_up[0].sub('h', '').to_i
      m = 0
    elsif  break_up[0].index('m') 
      h = 0
      m = break_up[0].sub('m', '').to_i
    else
      h=0
      m=0  
    end

    return ( (h.to_f * 60) + (m.to_f ) )/ 60 
  end


end
