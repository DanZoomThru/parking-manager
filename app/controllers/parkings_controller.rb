class ParkingsController < ApplicationController
  def index
    @parkings = Parking.all
  end

  def new
    @parking = Parking.new
  end

  def create
    @parking = Parking.new(parking_params)
    if @parking.save
      redirect_to "/"
    else
      render :new
    end
  end

  private

  def parking_params
    params.require(:parking).permit(:name, :address, :available, :has_camera, :has_watchman, :city, :zip_code, :main_picture, :price_month)
  end

end
