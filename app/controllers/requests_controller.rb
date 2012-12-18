class RequestsController < ApplicationController
  respond_to :html, :json
  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.page params[:page]
    @requests_method_count = Request.get_methods
    @requests_urls = Request.get_urls

    respond_with @requests
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @request = Request.find(params[:id])
    respond_with @requestss
  end

  # GET /requests/new
  # GET /requests/new.json
  def new
    @request = Request.new
    respond_with @request
  end

  # GET /requests/1/edit
  def edit
    @request = Request.find(params[:id])
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(params[:request])
    flash[:notice] = "Request was created successfully." if @request.save
    respond_with @request
  end

  # PUT /requests/1
  # PUT /requests/1.json
  def update
    @request = Request.find(params[:id])
    flash[:notice] = "Request was updated successfully." if @request.save
    respond_with @request
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    respond_with @request
  end
end
