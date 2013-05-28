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
    @developer = FactoryGirl.create(:developer)
    @project = FactoryGirl.create(:project)
    @category = FactoryGirl.create(:category)
  end

  after(:all) do
    @project.destroy
    @category.destroy
    @developer.destroy
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
