require 'spec_helper'

describe Invoice do
  
	before(:all) do 
		Invoice.destroy_all
	end


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
