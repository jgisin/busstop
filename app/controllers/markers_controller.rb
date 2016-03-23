 class MarkersController < ApplicationController
  before_action :set_marker, only: [:show, :edit, :update, :destroy]

  def index
    @markers = Marker.all
  end

  def show
  end

  def new
    @marker = Marker.new
  end


  def edit
  end


  def create
    @marker = Marker.new(marker_params)
    if @marker.save
      redirect_to @marker
    else
      render :new
    end
  end

  def update
    if @marker.update(marker_params)
      redirect_to @marker
    else
      render :edit
    end
  end


  def destroy
    if @marker.destroy
      redirect_to request.referrer
    end
  end

  private

    def set_marker
      @marker = Marker.find(params[:id])
    end


    def marker_params
      params.require(:marker).permit(:latitude, :longitude, :description, :address, :title)
    end
end
