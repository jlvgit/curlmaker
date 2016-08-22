class CurlsController < ApplicationController

  def index
  end

  def new
    @curl = Curl.new
  end

  def create
    @curl = Curl.new(curl_params)
    if @curl.save
      redirect_to curls_path
    else
      render :new
    end
  end

  def show
    @curl = Curl.find(params[:id])
  end

  def edit
    respond_to do |format|
      format.html { redirect_to curl_path }
      format.json { head :no_content }
      format.js   { render :layout => false }
   end
  end

private

  def curl_params
    params.require(:curl).permit(:id, :name, :method, :headers, :url, :data, :service)
  end
end
