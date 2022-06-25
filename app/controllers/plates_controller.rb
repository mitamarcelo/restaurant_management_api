class PlatesController < ApplicationController
  include RestaurantConcern
  before_action :authenticate_user!
  before_action :set_restaurant
  before_action :set_plate, only: %i[show update destroy]

  def index
    @plates = restaurant.plates
    render 'plates/index'
  end

  def show
    render 'plates/show'
  end

  def create
    @plate = Plate.create(plate_params.merge(restaurant:))
    if @plate
      render 'plates/show'
    else
      head :bad_request
    end
  end

  def update
    @plate.update(plate_params)
    if @plate.errors.empty?
      render 'plates/show'
    else
      head :bad_request
    end
  end

  def destroy
    @plate.destroy
    if @plate.errors.empty?
      head :no_content
    else
      head :bad_request
    end
  end

  private

  def plate_params
    params.require(:plate).permit(:name, :description, :price, :discount_price, :category, :discount_active)
  end

  def set_plate
    @plate = restaurant.plates.find(params[:id])
  end
end
