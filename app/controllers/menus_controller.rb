class MenusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_restaurant
  before_action :set_menu, only: %i[show update destroy]

  def index
    @menus = @restaurant.menus
    render 'menus/index'
  end

  def show
    render 'menus/show'
  end

  def create
    @menu = Menu.create(menu_params.merge(restaurant: @restaurant))
    if @menu
      render 'menus/show'
    else
      head :bad_request
    end
  end

  def update
    @menu.update(menu_params)
    if @menu.errors.empty?
      render 'menus/show'
    else
      head :bad_request
    end
  end

  def destroy
    @menu.destroy
    if @menu.errors.empty?
      head :no_content
    else
      head :bad_request
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :description, :active)
  end

  def set_menu
    @menu = @restaurant.menus.find(params[:id])
  end

  def set_restaurant
    @restaurant = current_user.restaurants.find(params[:restaurant_id])
  end
end
