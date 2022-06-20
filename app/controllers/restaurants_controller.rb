class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_restaurant, only: %i[show update destroy]
  def index
    @restaurants = current_user.restaurants
    render 'restaurants/index'
  end

  def show
    render 'restaurants/show'
  end

  def create
    @restaurant = Restaurant.create!(restaurant_params)
    if @restaurant
      current_user.restaurants << @restaurant
      render 'restaurants/show'
    else
      head :bad_request
    end
  end

  def update
    @restaurant.update!(restaurant_params)
    if @restaurant.errors.empty?
      render 'restaurants/show'
    else
      head :bad_request
    end
  end

  def destroy
    @restaurant.destroy!
    if @restaurant.errors.empty?
      head :no_content
    else
      head :bad_request
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def set_restaurant
    @restaurant = current_user.restaurants.find(params[:id])
  end
end
