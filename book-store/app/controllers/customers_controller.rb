class CustomersController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

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

  private

  def customer_params
    params.require(:customer).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end
