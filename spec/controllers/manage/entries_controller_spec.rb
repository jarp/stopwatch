require 'spec_helper'

describe Manage::EntriesController do

let(:valid_session) { { user: {id: @developer.id, email: 'test@test.com', name: 'tester'} } }

let(:valid_attr) { {
                    date:"2013-3-14", 
                    hours: '1h 45m', 
                    description: "my test work",
                    project_id: @project.id, 
                    category_id: @category.id, 
                    developer_id: @developer.id
                    } }

let(:valid_post) { {
                    entry: {
                    date:"3/23/2013", 
                    hours: '1h 45m', 
                    description: "my test work",
                    project_id: @project.id, 
                    category_id: @category.id, 
                    developer_id: @developer.id
                  }
                    } }
  
  before(:all) do 
  	@entry = FactoryGirl.create(:entry)
    @developer = FactoryGirl.create(:developer)
    @project = FactoryGirl.create(:project)
    @category = FactoryGirl.create(:category)
  end

  after(:all) do
  	@entry.destroy
    @project.destroy
    @category.destroy
    @developer.destroy
  end


  describe "Create Entry" do 
  
    it "create a new entry" do
      post 'create', valid_post, valid_session
      expect(response.code).to eq "302"
      #expect(response).to  redirect_to manage_entry_path
    end
  end

  describe "Update Entry" do 

     it "updates the requested entry" do
        entry = Entry.create! valid_attr
    	expect(entry.invoiced?).to_not be_true
        #Entry.any_instance.should_receive(:update_attributes).with({ "description" => "Updated Entry for test" })
        put :update, {:id => entry.to_param, :entry => { "description" => "Updated Entry for test", "invoice_date" => "4/24/2013" }}, valid_session
        #pp assigns(:entry)
        expect(assigns(:entry).invoiced?).to be_true
      end
  end


  describe "make entry as invoiced" do 
  
  	it "should take an id and mark it as invoiced" do
		entry = Entry.create! valid_attr
		expect(entry.invoiced?).to_not be_true
		expect(assigns(:entry).invoiced?).to be_true
  	end
  end



end
