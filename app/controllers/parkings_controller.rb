class ParkingsController < ApplicationController
  before_action :set_parkings, only: [:index, :map]
  before_action :set_parking, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @parking = Parking.new
  end

  def create
    @parking = Parking.new(parking_params)
    @parking.district = @parking.zip_code[0..1] == "75" ? @parking.zip_code[3..4] : "0"
    gps = Geokit::Geocoders::GoogleGeocoder.geocode(@parking.address + ", " + @parking.city)
    @parking.lat = gps.ll.split(',').first.to_f
    @parking.lng = gps.ll.split(',').last.to_f
    if @parking.save
      redirect_to "/"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @parking.update(parking_params)
    new_district = @parking.zip_code[0..1] == "75" ? @parking.zip_code[3..4] : "0"
    gps = Geokit::Geocoders::GoogleGeocoder.geocode(@parking.address + ", " + @parking.city)
    new_lat = gps.ll.split(',').first.to_f
    new_lng = gps.ll.split(',').last.to_f
    @parking.update(lat: new_lat, lng: new_lng, district: new_district)
    redirect_to "/"
  end

  def destroy
    @parking.destroy
    redirect_to "/"
  end

  def map
  end

  private

  def parking_params
    params.require(:parking).permit(:name, :address, :available, :has_camera, :has_watchman, :city, :zip_code, :main_picture, :price_month)
  end

  def set_parking
    @parking = Parking.find(params[:id])
  end

  def set_parkings
    @parkings = Parking.all
  end

end
