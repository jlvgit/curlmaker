class CurlsController < ApplicationController
  before_action :authenticate_user!

  def list
  end

  def home
  end

  def new
    @curl = Curl.new
  end

  def create
    @curl = Curl.new(curl_params)
    if @curl.save
      flash[:success] = "New entry created successfully!"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @curl = Curl.find(params[:id])
    render :show
  end

  def edit
    @curl = Curl.find(params[:id])
  end

  def update
    @curl = Curl.find(params[:id])
    if @curl.update(curl_params)
      flash[:success] = "Update successful!"
      redirect_to curl_path
    else
      render :new
    end
  end

  def destroy
    @curl = Curl.find(params[:id])
    @curl.destroy
    redirect_to root_path
  end

private

  def curl_params
    params.require(:curl).permit(:id, :name, :method, :headers, :url, :data, :service, :notes)
  end
end
