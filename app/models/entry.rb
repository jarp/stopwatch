class Entry < ActiveRecord::Base
  attr_accessible :date, :description, :time,  :hours, :project_id, :developer_id, :category_id, :invoice_date, :state

  belongs_to :developer
  belongs_to :project
  belongs_to :category
  belongs_to :invoice


  validates :date, :description, :hours,:developer_id, :project_id, :category_id,  :presence => true

	after_create :default_values
  before_save :set_state

  scope :invoiced, where(:state => 'invoiced')
  scope :orphan, where(:state => 'orphan')
  scope :assigned, where(:state => 'assigned')
  scope :available, where("state <> 'invoiced'")
  

  def convert_dates
    self.date = Date.strptime(self.date, '%m/%d/%Y')
  end

  def invoiced?
    if invoice_date.nil?
      false
    else
      true
    end
  end


  

  def date_is_legit
    errors.add(:date, "must be a valid date but was [#{date}]") 
    	if ( (Date.strptime(date, '%m/%d/%Y') rescue ArgumentError) == ArgumentError)
    end  end

  def payment
    ratio * category.rate
  end

  def ratio
    
    break_up = self.hours.split(' ')

    if self.hours.blank?
      h = 0
      m = 0
    elsif break_up.count == 2
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

  #private 

  def default_values
    d = Time.new
    self.date ||= Time.new.strftime('%m/%d/%Y')
    self.state = "orphan"
  end

  def set_state
    if self.invoice && self.invoice.sent_date
      self.state = 'invoiced'
    
    elsif self.invoice_id.nil?
      self.state = 'orphan'
    else
      self.state = 'assigned'
    end

  end

end
