class Invoice < ActiveRecord::Base
  belongs_to :developer
  belongs_to :project
  has_many :entries

  attr_accessible :sent_date, :developer_id, :project_id

  def self.current(developer_id, project_id)
    Invoice.find_or_create_by_developer_id_and_project_id_and_sent_date(developer_id, project_id, nil)
  end

  def submitted?
    sent?
  end


  def sent?
  	if sent_date
  		true
  	else
  		false
  	end
  end
end
