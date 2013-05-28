require 'spec_helper'

describe Manage::CategoriesController do

let(:valid_attributes) { { name: "Test Category", code: 'test',  rate: 50  } }
let(:valid_session) { { user: {id: 1, email: 'test@test.com', name: 'tester'} } }

context "user is logged in " do

	describe "GET index" do
	    it "assigns all categories as @category" do
	      category = Category.create! valid_attributes
	      get :index, {}, valid_session
	      assigns(:categories).should eq([category])
	    end
  end

end
end
