class OrdersController < ApplicationController
  before_action :only_auth_resource

  def index

  end

  def new_item
    @order = Order.where(customer: @current_customer, state: :in_progress).first
    if !@order
      @order = Order.new(customer: @current_customer)
      @order.save
    end

    @new_item = @order.add_book(params[:book_id], params[:quantity])
    @new_item.save

    render :edit
  end

  def update

  end

  def show

  end
end
