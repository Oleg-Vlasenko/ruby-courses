class OrdersController < ApplicationController
  before_action :only_auth_resource
  before_action :select_upd_action, only: :update

  def index
    @order = @current_customer.get_current_order
    @completed_orders = @current_customer.get_orders(:completed)
    @shipped_orders = @current_customer.get_orders(:shipped)
  end
  
  def show
    @order = Order.find_by_id(params[:id]) or not_found
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
    @order = Order.find_by_id(params[:id]) or not_found

    @order.items.each do |item|
      item_num = item.new_record? ? "new_item" : "item_#{item.id}"
      if params["#{item_num}_del_flag"] == '1'
        item.destroy
      end
    end

    # not saved item
    if params[:new_item_qty] && params[:new_item_del_flag] != '1'
      @order.add_book(params[:new_item_book_id], params[:new_item_qty])
    end

    is_valid = true
    @order.items.each do |item|
      next if item.destroyed?
      
      item_num = item.new_record? ? "new_item" : "item_#{item.id}"
      new_quantity = params["#{item_num}_qty"].to_i
      if item.quantity != new_quantity
        item.quantity = new_quantity
      end

      is_valid = item.valid? if is_valid
    end

    if is_valid
      @order.items.each do |item|
        next if item.destroyed?
  
        item.save
      end
      
      redirect_to @order
      
    else
      render :edit
    end
  end
  
  def empty_cart
    @order = Order.find_by_id(params[:id]) or not_found
    
    @order.items.each do |item|
      item.destroy
    end
    
    redirect_to :root
  end
  
  private
  
  def select_upd_action
    empty_cart if params[:empty_cart]
  end

end

