class DevelopersController < ApplicationController
  # GET /developers
  # GET /developers.json
  def index
    @developers = Developer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @developers }
    end
  end

  # GET /developers/1
  # GET /developers/1.json
  def show
    @developer = Developer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @developer }
    end
  end

  # GET /developers/new
  # GET /developers/new.json
  def new
    @developer = Developer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @developer }
    end
  end

  # GET /developers/1/edit
  def edit
    @developer = Developer.find(params[:id])
  end

  # POST /developers
  # POST /developers.json
  def create
    @developer = Developer.new(params[:developer])

    respond_to do |format|
      if @developer.save
        format.html { redirect_to @developer, notice: 'Developer was successfully created.' }
        format.json { render json: @developer, status: :created, location: @developer }
      else
        format.html { render action: "new" }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /developers/1
  # PUT /developers/1.json
  def update
    @developer = Developer.find(params[:id])

    respond_to do |format|
      if @developer.update_attributes(params[:developer])
        format.html { redirect_to @developer, notice: 'Developer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /developers/1
  # DELETE /developers/1.json
  def destroy
    @developer = Developer.find(params[:id])
    @developer.destroy

    respond_to do |format|
      format.html { redirect_to developers_url }
      format.json { head :no_content }
    end
  end
end
