require "#{Rails.root}/app/api/geo_locate.rb"
class UsersController < ApplicationController


  def index
    @markers = Marker.all
    @hash = Gmaps4rails.build_markers(@markers) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow "#{user.title}: #{user.description}  ||   Next Stop: #{Marker.next_stop(user.id).length > 0 ? Marker.next_stop(user.id).first.departure_time.strftime("%H:%M") : "No More Stop Today"}"
    end
  end

  def show
    @user = User.last
    @markers = Marker.closest(@user.latitude, @user.longitude)
    @hash = Gmaps4rails.build_markers(@markers) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow "#{user.title}: #{user.description}  ||   Next Stop: #{Marker.next_stop(user.id).length > 0 ? Marker.next_stop(user.id).first.departure_time.strftime("%H:%M") : "No More Stop Today"}"
    end
  end

  def new
    geo = GeoLoc.new("73.78.33.1")
    puts geo.run
    @user = User.new
    @user.latitude = geo.run[:lat].to_s
    @user.longitude = geo.run[:long].to_s
    if @user.save
      redirect_to @user
     end
  end

  private
  def user_params
    params.permit(:latitude, :longitude)
  end

end
