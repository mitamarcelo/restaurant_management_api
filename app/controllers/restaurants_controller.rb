class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  def index
    @restaurants = current_user.restaurants
    render 'restaurants/index'
  end

  def show
    @restaurant = current_user.restaurants.find(:id)
    render 'restaurants/show'
  end

  def create; end

  def update; end

  def destroy; end
end
