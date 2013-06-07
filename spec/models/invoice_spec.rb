require 'spec_helper'

describe Invoice do

  after(:all) do 
	Invoice.destroy_all
	Entry.destroy_all
  end
  
  describe "has basic  invoice functions like " do



	it "should return the current invoice" do
		me 				= FactoryGirl.create(:developer)
		them 			= FactoryGirl.create(:developer)
		myProject 		= FactoryGirl.create(:project, {})
		theirProject 	= FactoryGirl.create(:project, {})

		count = Invoice.all.count

		invoice = Invoice.current(me.id, myProject.id)

		expect(Invoice.all.count).to eq count + 1
		expect(invoice).to_not be_nil

		invoice = Invoice.current(me.id, myProject.id)
	
		expect(Invoice.all.count).to eq count + 1
	end

  end



  describe "controls the state of its entries" do

	before(:each) do
		@invoice = FactoryGirl.create(:invoice)
		@entry = FactoryGirl.create(:entry, {description: "init entry"})
	end

	after(:each) do 

		@invoice.destroy
		@entry.destroy

	end

	it "should return 'orphan' for orphaned invoice" do 
		#pp "running orphanned"
		expect(@entry.state).to eq "orphan"
	end


	it "should return assigned for entry once it has an invoice" do
		
		
		@entry.invoice_id = @invoice.id
		@entry.description = "has been assigned"

		@entry.save

		@assigned_entry = Entry.find(@entry.id)
		expect(@entry.state).to eq "assigned"
		@assigned_entry.destroy
	end

	it "should return 'invoiced' once invoice is processed " do 

		@entry.invoice_id = @invoice.id
		@entry.description = "being processed"
		@entry.save
		
		#process invoice by seting date
		
		@invoice = Invoice.find(@invoice.id)
		@invoice.sent_date = Time.now
		@invoice.save
		
		updated_entry = Entry.find(@entry.id)
		expect(updated_entry.state).to eq "invoiced"

	
	end
	

	it "should mark them as assigned if invoice is revoked" do 
		
		@entry.invoice_id = @invoice.id
		@entry.description = "being processed"
		@entry.save
		
		#process invoice by seting date
		
		@invoice = Invoice.find(@invoice.id)
		@invoice.sent_date = Time.now
		@invoice.save
		
		updated_entry = Entry.find(@entry.id)
		expect(updated_entry.state).to eq "invoiced"
		
		@invoice = Invoice.find(@invoice.id)
		@invoice.sent_date = nil
		@invoice.save

		updated_entry = Entry.find(@entry.id)
		expect(updated_entry.state).to eq "assigned"
	end

  end


end

