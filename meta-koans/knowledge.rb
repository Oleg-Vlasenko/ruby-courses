class Module
  def create_attr(name, val)
    instance_variable_set %Q{@#{name}}, val
    instance_eval %Q{ attr_accessor :#{name} }
    module_eval %Q{ def #{name}?
        instance_variable_get(%Q{@#{name}})
      end }
  end

  def attribute attr, &block
    if attr.is_a?(Hash)
      attr.each { |key, val| self.create_attr(key, val) }
    else
      val = block_given? ? instance_eval(&block) : 0
      self.create_attr(attr, val)
    end
  end

  def method_missing meth
    module_eval(%Q{def #{meth}
      end})
  end
end