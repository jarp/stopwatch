require 'spec_helper'

describe InvoicesController do
  
  let(:valid_attributes) { { "developer_id" => @developer.id, "project_id" => @project.id } }
  let(:valid_session) { { user: {id: @developer.id, email: 'test@test.com', name: 'tester'} } }

  before(:all) do 
    Invoice.destroy_all
    
    @project = FactoryGirl.create(:project)
    @developer = FactoryGirl.create(:developer)
    @entry = FactoryGirl.create(:entry, {description: "first entry for test", developer_id: @developer.id, project_id: @project.id})
    @entry2 = FactoryGirl.create(:entry, {description: "second entry for test", developer_id: @developer.id, project_id: @project.id})
    @invoice = FactoryGirl.create(:invoice)
  
  end

  after(:all) do
  	@project.destroy
  	@developer.destroy
    @invoice.destroy
    @entry.destroy
    @entry2.destroy
  end


  describe "process invoices" do

    it "submitting an invoice" do
      
      get :submit, {id: @invoice.id}, valid_session      
      expect(assigns(:invoice).submitted?).to be_true

    end

    it "unsubmits an invoice" do
        
        @invoice.sent_date = '2013-3-23'
        @invoice.save

        expect(@invoice.submitted?).to be_true
        
        post :unsubmit, {id: @invoice.id}, valid_session      
        expect(assigns(:invoice).submitted?).to be_false

    end

  end


  describe "current invoice" do 


    it "should be my current invoice with entires" do
      @entry.invoice_id = @invoice.id
      @entry.save
      @entry2.invoice_id = @invoice.id
      @entry2.save
      #pp @invoice.entries
      get :current, {project_id: @project.id}, valid_session
      
      expect(assigns(:invoice)).to_not be_nil
      expect(assigns(:entries)).to_not be_nil
      expect(assigns(:entries)).to be_a_kind_of Array
      #expect(assigns(:entries).first).to be_a_kind_of Entry
      #expect(assigns(:entries).first).to eq @entry
    end

    it "should send the invoice far far away and mark it so" do
      pending "no test"
    end


    it 'should gracefully handle current without id if mulitple projects are available' do
      pending "not test"
    end

    it "should show the current invoice for project if only one project is available"
      pending "no test"
    end

  

  describe "Add and remove entries from an invoice" do

    it "adds an entry to invoice" do
      mime_type = mock
      mime_type.stub :ref => :json
      request.stub :content_mime_type => mime_type
      request.accept = 'application/json'

      get :addEntry, {entry_id: @entry.id}, valid_session

      expect(response.code).to eq  "200"
      expect(assigns(:invoice)).to_not be_nil
      expect(assigns(:invoice).entries.count).to eq 1

      get :addEntry, {entry_id: @entry2.id}, valid_session      
      expect(assigns(:invoice).entries.count).to eq 2

      @invoice = Invoice.find(assigns(:invoice).id)
      #pp @invoice.entries

      expect(@invoice.entries.count).to eq 2
    end


    it "removes an invoice" do
     
  
      @entry.invoice_id = @invoice.id
      @entry.save
      @entry2.invoice_id = @invoice.id
      @entry2.save

      @invoice_before = Invoice.find(@invoice.id)
      

      expect(@invoice_before.entries.count).to eq 2

      mime_type = mock
      mime_type.stub :ref => :json
      request.stub :content_mime_type => mime_type
      request.accept = 'application/json'

      get :removeEntry, {entry_id: @entry.id}, valid_session

      expect(response.code).to eq  "200"
      expect(assigns(:invoice)).to_not be_nil

      #pp assigns(:invoice)
      @invoice_after = Invoice.find(@invoice.id)
      expect(@invoice_after.entries.count).to eq 1

      @invoice_before.destroy
      @invoice_after.destroy
    end

  end


 describe "GET index" do
    it "assigns all invoices as @invoices" do
      #invoice = Invoice.create! valid_attributes
      get :index, {}, valid_session
      assigns(:invoices).should eq([@invoice])
    end
  end

  describe "GET show" do
    it "assigns the requested invoice as @invoice" do
      invoice = Invoice.create! valid_attributes
      get :show, {:id => invoice.to_param}, valid_session
      assigns(:invoice).should eq(invoice)
    end
  end


 
end
