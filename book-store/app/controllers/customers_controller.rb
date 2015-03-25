class CustomersController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]
  before_action :only_auth_resource, only: [:edit_settings, :update_settings]

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
        session[:customer_id] = @customer.id
        redirect_to root_path
    else
      render :new
    end
  end
  
  def edit_settings
    @customer = @current_customer
    unless @customer.billing_address
      @customer.billing_address = BillingAddress.new(first_name: @customer.first_name, last_name: @customer.last_name)
    end
    unless @customer.shipping_address
      @customer.shipping_address = ShippingAddress.new(first_name: @customer.first_name, last_name: @customer.last_name)
    end
  end
  
  def update_settings
    @customer = @current_customer
    if @current_customer.update_settings(customer_settings_params)
      @current_customer.save
      redirect_to root_path;
    else
      @customer = @current_customer
      render :edit_settings
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
  
  def customer_settings_params
    settings_params = Hash.new
    settings_params[:customer] = params.require(:customer).permit(:first_name, :last_name, :email)
    settings_params[:billing_address] = params.require(:customer).require(:billing_address).permit(:first_name, :last_name, :address, :city, :country, :zip_code, :phone)
    settings_params[:shipping_address] = params.require(:customer).require(:shipping_address).permit(:first_name, :last_name, :address, :city, :country, :zip_code, :phone)
    settings_params[:password] = params.require(:password).permit(:current, :new)
    settings_params
  end

end
