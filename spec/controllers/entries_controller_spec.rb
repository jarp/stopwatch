require 'spec_helper'

describe EntriesController do

let(:valid_session) { { user: {id: @developer.id, email: 'test@test.com', name: 'tester'} } }
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
    Entry.destroy_all
    Developer.destroy_all
    Project.destroy_all
    @developer = FactoryGirl.create(:developer, {first_name: 'dev1'})
    @developer2 = FactoryGirl.create(:developer, {first_name: 'dev2', email:'dev2@test.com'})
    @project = FactoryGirl.create(:project)
    @category = FactoryGirl.create(:category)
  end

  after(:all) do
    @project.destroy
    @category.destroy
    @developer.destroy
    @developer2.destroy
  end


    it "returns a list of all entries that have not been invoiced" do 
      FactoryGirl.create(:entry, {developer_id: @developer.id})
      FactoryGirl.create(:entry, {developer_id: @developer2.id})

      get :index, {}, valid_session
      pp assigns(:entries)
      expect(assigns(:entries)).to_not be_nil
      expect(assigns(:entries).count).to eq 2
      #expect(assigns(:entries).first.developer).to_not be_nil
      #pp assigns(:entries)
    end

  it "returns a list of all entries that have not been invoiced filtered by dev's email" do 
      
      FactoryGirl.create(:entry, {developer_id: @developer.id})
      FactoryGirl.create(:entry, {developer_id: @developer2.id})
      #pp @developer2
      #pp @developer2.entries
      
      get :index, {"email" => @developer2.email}, valid_session
      
      expect(assigns(:entries)).to_not be_nil
      expect(assigns(:entries).count).to eq 1
      expect(assigns(:entries).first.developer_id).to eq @developer2.id
      #pp assigns(:entries)
    end

    it "posts a new entry" do
      mime_type = mock
      mime_type.stub :ref => :json
      request.stub :content_mime_type => mime_type
      request.accept = 'application/json'
      
      post 'create', valid_post, valid_session
      #pp response.body

      expect(response.code).to eq "201"
      
    end

end
