require 'spec_helper'


describe Entry do

	let(:entry) { entry = FactoryGirl.build(:entry, {date: "3/23/2013", hours:"35m"})	 }

describe "custom scopes" do 
	
	before(:all) do
		pp "before all"
		Entry.destroy_all
		@invoice = FactoryGirl.create(:invoice)
		@invoiced = FactoryGirl.create(:invoice, {sent_date: "2013-3-23"})
		@project = FactoryGirl.create(:project)
		FactoryGirl.create(:entry, {project_id: @project.id})		
		FactoryGirl.create(:entry, {project_id: @project.id})		
		FactoryGirl.create(:entry, {project_id: @project.id, invoice_id: @invoice.id})		
	end
	
	
	it "returns all unassigned entrys as a class method" do 
		@unassigned_entries = Entry.unassigned
		expect(@unassigned_entries).to_not be_nil
		expect(@unassigned_entries.count).to eq 2

	end

	it "returns all uninvoiced entrys as a class method" do 
	
		FactoryGirl.create(:entry, {project_id: @project.id, invoice_id: @invoiced.id})	

		@open_entries = Entry.open
		expect(@open_entries).to_not be_nil
		expect(@open_entries.count).to eq 3

	end

	it "returns all assigned entrys as a class method" do 
		FactoryGirl.create(:entry, {project_id: @project.id, invoice_id: @invoice.id})	
		FactoryGirl.create(:entry, {project_id: @project.id, invoice_id: @invoiced.id})	
		@assigned_entries = Entry.assigned
		expect(@assigned_entries).to_not be_nil
		expect(@assigned_entries.count).to eq 2

	end

end



=begin
	it "converts date before validation" do 
		@entry = FactoryGirl.create(:entry, {date: "5/24/2013", hours:"35m"})		
		expect(@entry.date).to_not be_nil
		pp @entry
		@entry.destroy
	end
	it "accepts basic date" do
		entry = FactoryGirl.build(:entry, {date: "5/24/2013", hours:"35m"})		
		expect(entry.date).to_not be_nil
	end
  
=end

  	describe "the ratio method" do 
	
		it "translates the 1h 30m format to the ratio in hours" do 
			entry = FactoryGirl.build(:entry, {hours:"1h 30m"})
			expect(entry.ratio).to eq 1.5
		end
	
		it "returns 0 if blank" do 
			entry = FactoryGirl.build(:entry, {hours:""})
			expect(entry.ratio).to eq 0
		end

		it "supports just hours" do 
			entry = FactoryGirl.build(:entry, {hours:"1h"})
			expect(entry.ratio).to eq 1
		end		

		it "supports just minutes" do 
			entry = FactoryGirl.build(:entry, {hours:"30m"})
			expect(entry.ratio).to eq '.5'.to_f
		end		

	end


	describe "invoice methods" do

		it "should return t/f  based on if there is an invoice date" do 
			
			entry = FactoryGirl.build(:entry, {date: DateTime.now, hours:"35m"})
			#pp entry
			expect(entry.invoiced?).to be_false


			invoiced_entry = FactoryGirl.build(:entry, {date: DateTime.now, invoice_date: DateTime.now, hours:"35m"})
			#pp invoiced_entry
			expect(invoiced_entry.invoiced?).to be_true

		end

		it "should update entry with current date as invoice date if invoice is called" do
			pending "no test"
		end
	end


	describe "validation methods" do 
		

		it "should validate date" do 
			pending "needs test"
=begin
			entry = FactoryGirl.build(:entry, {date: DateTime.new, hours:"35m"})
			entry.valid?
			pp entry.errors
			expect(entry.errors).to be_nil
=end
		end
	end


end
