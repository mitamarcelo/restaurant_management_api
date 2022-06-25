module RestaurantConcern
  extend ActiveSupport::Concern

  def restaurant
    @restaurant
  end

  private

  def set_restaurant
    @restaurant = current_user.restaurants.find(params[:restaurant_id])
  end
end
