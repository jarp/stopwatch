class Invoice < ActiveRecord::Base
  belongs_to :developer
  belongs_to :project
  has_many :entries

  attr_accessible :sent_date, :developer_id, :project_id

  after_save :update_entry_states
  before_destroy :orphan_entries

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

  def update_entry_states
    #puts self.sent_date
    
    if self.sent_date 
      process_entries
    else
      unprocess_entries
    end
  end

  def process_entries
    
      self.entries.each do | e |
      
    
        ent = Entry.find(e.id)

        ent.state = 'invoiced'
        ent.save
      end
  
  end

  def unprocess_entries
    #puts "********** unprocessing entries"
    self.entries.each do | entry |
      
        entry.state = "assigned"
        entry.save
      
      end
  end

  def orphan_entries
    self.entries.each do | entry |
        entry.invoice = nil
      end
  end


end
