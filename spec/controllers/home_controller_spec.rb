require 'spec_helper'

describe HomeController do

let(:valid_session) { { user: {id: 1, email: 'test@test.com', name: 'tester'} } }

  before(:all) do 
    @developer = Developer.create!({email: "tester@test.com", first_name: "Test", last_name: "Tester", password: "1234"})
  end

  after(:all) do
    @developer.destroy
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', {}, valid_session
      expect(response).to be_success
      expect(assigns(:developers)).to_not be_nil
      expect(assigns(:entry)).to_not be_nil 

    end
  end

  describe "GET 'login'" do
    it "returns http success" do
      get 'login'
      response.should be_success
    end
  end

  describe "GET 'logout'" do
    it "returns http success" do
      get 'logout', {}, valid_session
      expect(response.code).to eq "302"
      expect(response).to redirect_to login_path
      expect(session[:user]).to be_nil
    end
  end

  describe "POST 'authenticate'" do
    it "user in and returns to home" do
      post 'authenticate', {email: "tester@test.com", password: "1234"}
      expect(response.code).to eq "302"
      expect(response).to redirect_to home_path
      expect(flash[:message]).to_not be_nil
      expect(session[:user]).to_not be_nil

    end
  end

end
