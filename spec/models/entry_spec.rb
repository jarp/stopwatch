require 'spec_helper'


describe Entry do

	let(:entry) { entry = FactoryGirl.build(:entry, {date: "3/23/2013", hours:"35m"})	 }


describe "basic properties" do

	it "should have state and" do 
		@entry = FactoryGirl.create(:entry)
		pp 	@entry
		expect(@entry.state).to_not be_nil
		@entry.destroy		
	end
end


describe "custom scopes" do 
	
	before(:each) do
		@invoice = FactoryGirl.create(:invoice)
		@invoiced = FactoryGirl.create(:invoice, {sent_date: "2013-3-23"})
		@project = FactoryGirl.create(:project)

		#create 4 entries
		# 2 unassigned
		# 1 assigned but not invoices
		# 1 assigned and invoiced

		FactoryGirl.create(:entry, {project_id: @project.id})		
		FactoryGirl.create(:entry, {project_id: @project.id})		
		FactoryGirl.create(:entry, {project_id: @project.id, invoice_id: @invoice.id})		
		FactoryGirl.create(:entry, {project_id: @project.id, invoice_id: @invoiced.id})	
	end

	after(:each) do 
		Invoice.destroy_all
		Project.destroy_all
		Entry.destroy_all
	end
	
	it "should return all open entries (not invoiced)" do 
		@open_entries = Entry.available
		expect(@open_entries).to_not be_nil
		expect(@open_entries.count).to eq 3
		expect(@open_entries.first).to be_a_kind_of Entry
	end	


	it "returns all unassigned entrys as a class method" do 
		@unassigned_entries = Entry.invoiced
		expect(@unassigned_entries).to_not be_nil
		expect(@unassigned_entries.count).to eq 1
	end

	it "returns all uninvoiced entrys as a class method" do 
	
		@open_entries = Entry.orphan
		expect(@open_entries).to_not be_nil
		expect(@open_entries.count).to eq 2

	end

	it "returns all assigned entrys as a class method" do 
		@assigned_entries = Entry.assigned
		pp @assigned_entries.first
		expect(@assigned_entries).to_not be_nil
		expect(@assigned_entries.count).to eq 1
		expect(@assigned_entries.first.developer).to_not be_nil
		

	end

end

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

		
	end


	describe "validation methods" do 
		

	end


end
