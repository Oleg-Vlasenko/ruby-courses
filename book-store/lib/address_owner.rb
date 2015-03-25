module AddressOwner
  def set_billing_address(addr_data)
    if self.billing_address
      self.billing_address.update(addr_data)
    else
      self.billing_address = BillingAddress.create(addr_data)
    end
  end

  def set_shipping_address(addr_data)
    if self.shipping_address
      self.shipping_address.update(addr_data)
    else
      self.shipping_address = ShippingAddress.create(addr_data)
    end
  end
end