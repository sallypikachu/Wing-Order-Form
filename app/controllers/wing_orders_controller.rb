class WingOrdersController < ApplicationController
  def index
    @wing_orders = WingOrder.all
  end

  def new
    @wing_order = WingOrder.new
    @state_collection = WingOrder::STATES
    @quantity_collection = WingOrder::QUANTITIES
    @flavor_collection = Flavor.all
  end

  def create
    @wing_order = WingOrder.new(wing_order_params)
    require 'pry'
    binding.pry
    if @wing_order.save
      flash[:notice] = "Wing order created!"
      redirect_to wing_orders_path
    else
      flash[:alert] = "Wing order not created"
      @state_collection = WingOrder::STATES
      @quantity_collection = WingOrder::QUANTITIES
      @flavor_collection = Flavor.all
      erb :new
    end
  end

  private

  def wing_order_params
    params.require(:wing_order).permit(
      :customer_name,
      :city,
      :state,
      :quantity,
      :dressing,
      flavor_ids: []
    )
  end
end
