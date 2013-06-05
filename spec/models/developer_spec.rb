require 'spec_helper'


describe Developer do


describe "associations" do 
	
	before(:all) do
		@project = FactoryGirl.create(:project)
		@developer = FactoryGirl.create(:developer)
		@other_developer = FactoryGirl.create(:developer)
		
		FactoryGirl.create(:entry, {project_id: @project.id, developer_id: @developer.id})		
		FactoryGirl.create(:entry, {project_id: @project.id, developer_id: @developer.id})
		FactoryGirl.create(:entry, {project_id: @project.id, developer_id: @other_developer.id})		
			
	end
	
	it "should return all open entries (not invoiced)" do 
		expect(@developer.projects.count).to eq 2
	end	



end




end
