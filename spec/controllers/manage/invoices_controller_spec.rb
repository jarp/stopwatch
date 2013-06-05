require 'spec_helper'

describe Manage::InvoicesController do
  
  let(:valid_attributes) { { "developer_id" => @developer.id, "project_id" => @project.id } }
  let(:valid_session) { { user: {id: @developer.id, email: 'test@test.com', name: 'tester'} } }

  before(:all) do 
    Invoice.destroy_all
    @project = FactoryGirl.create(:project)
    @developer = FactoryGirl.create(:developer)
    @entry = FactoryGirl.create(:entry, {description: "first entry for test", developer_id: @developer.id, project_id: @project.id})
    @entry2 = FactoryGirl.create(:entry, {description: "second entry for test", developer_id: @developer.id, project_id: @project.id})
    @invoice = FactoryGirl.create(:invoice)
    #@invoice = Invoice.new(developer_id: @developer.id, project_id: @project.id).save 
  
  end

  after(:all) do
  	@project.destroy
  	@developer.destroy
    @invoice.destroy
    @entry.destroy
    @entry2.destroy
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

  describe "GET new" do
    it "assigns a new invoice as @invoice" do
      get :new, {}, valid_session
      assigns(:invoice).should be_a_new(Invoice)
    end
  end

  describe "GET edit" do
    it "assigns the requested invoice as @invoice" do
      invoice = Invoice.create! valid_attributes
      get :edit, {:id => invoice.to_param}, valid_session
      assigns(:invoice).should eq(invoice)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Invoice" do
        expect {
          post :create, {:invoice => valid_attributes}, valid_session
        }.to change(Invoice, :count).by(1)
      end

      it "assigns a newly created invoice as @invoice" do
        post :create, {:invoice => valid_attributes}, valid_session
        assigns(:invoice).should be_a(Invoice)
        assigns(:invoice).should be_persisted
      end

      it "redirects to the created invoice" do
        post :create, {:invoice => valid_attributes}, valid_session
        response.should redirect_to(manage_invoice_path(Invoice.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved invoice as @invoice" do
        # Trigger the behavior that occurs when invalid params are submitted
        Invoice.any_instance.stub(:save).and_return(false)
        post :create, {:invoice => { "developer_id" => "invalid value" }}, valid_session
        assigns(:invoice).should be_a_new(Invoice)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Invoice.any_instance.stub(:save).and_return(false)
        post :create, {:invoice => { "developer_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested invoice" do
        invoice = Invoice.create! valid_attributes
        # Assuming there are no other invoices in the database, this
        # specifies that the Invoice created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Invoice.any_instance.should_receive(:update_attributes).with({ "developer_id" => @developer.id.to_s })
        put :update, {:id => invoice.to_param, :invoice => { "developer_id" => @developer.id }}, valid_session
      end

      it "assigns the requested invoice as @invoice" do
        invoice = Invoice.create! valid_attributes
        put :update, {:id => invoice.to_param, :invoice => valid_attributes}, valid_session
        assigns(:invoice).should eq(invoice)
      end

      it "redirects to the invoice" do
        invoice = Invoice.create! valid_attributes
        put :update, {:id => invoice.to_param, :invoice => valid_attributes}, valid_session
        response.should redirect_to(manage_invoice_path(invoice))
      end
    end

    describe "with invalid params" do
      it "assigns the invoice as @invoice" do
        invoice = Invoice.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Invoice.any_instance.stub(:save).and_return(false)
        put :update, {:id => invoice.to_param, :invoice => { "developer_id" => "invalid value" }}, valid_session
        assigns(:invoice).should eq(invoice)
      end

      it "re-renders the 'edit' template" do
        invoice = Invoice.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Invoice.any_instance.stub(:save).and_return(false)
        put :update, {:id => invoice.to_param, :invoice => { "developer_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested invoice" do
      invoice = Invoice.create! valid_attributes
      expect {
        delete :destroy, {:id => invoice.to_param}, valid_session
      }.to change(Invoice, :count).by(-1)
    end

    it "redirects to the invoices list" do
      invoice = Invoice.create! valid_attributes
      delete :destroy, {:id => invoice.to_param}, valid_session
      response.should redirect_to(manage_invoices_path)
    end
  end

end
