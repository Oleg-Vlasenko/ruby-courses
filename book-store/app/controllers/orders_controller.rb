class OrdersController < ApplicationController
  before_action :only_auth_resource
  before_action :select_upd_action, only: :update

  def index
    @order = @current_customer.get_current_order
    @completed_orders = @current_customer.get_orders(:completed)
    @shipped_orders = @current_customer.get_orders(:shipped)
  end
  
  def show
    @order = Order.find_by_id(params[:id]) || not_found
  end
  
  def edit
    @order = @current_customer.get_current_order!
  end

  def new_item
    @order = @current_customer.get_current_order!

    new_item = @order.add_book(params[:book_id], params[:quantity])
    new_item.valid?

    render :edit
  end

  def update
    @order = Order.find_by_id(params[:id]) || not_found

    @order.items.each do |item|
      item_num = item.new_record? ? "new_item" : "item_#{item.id}"
      if params["#{item_num}_del_flag"] == '1'
        item.destroy
      end
    end

    is_valid = true
    @order.items.each do |item|
      next if item.destroyed?
      
      new_quantity = params["item_#{item.id}_qty"].to_i
      if item.quantity != new_quantity
        item.quantity = new_quantity
        item.save
      end

      is_valid = item.valid? if is_valid
    end

    # new item
    if params[:new_item_qty] && params[:new_item_del_flag] != '1'
      new_item = @order.add_book(params[:new_item_book_id], params[:new_item_qty])
      is_valid = new_item.valid? if is_valid
    end

    if is_valid
      redirect_to @order
    else
      render :edit
    end
  end
  
  def empty_cart
    @order = Order.find_by_id(params[:id]) || not_found
    
    @order.items.each do |item|
      item.destroy
    end
    
    redirect_to :root
  end
  
  def checkout_address
  end
  
  def update_checkout_address
  end

  def checkout_delivery
  end
  
  def update_checkout_delivery
  end
  
  private
  
  def select_upd_action
    if params[:empty_cart]
      empty_cart 
    elsif params[:to_root]
      redirect_to :shop
    end
  end

end
