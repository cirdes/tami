class RequestsController < ApplicationController
  respond_to :html, :json
  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all
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
    respond_with @request
  end

  # PUT /requests/1
  # PUT /requests/1.json
  def update
    @request = Request.find(params[:id])
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
