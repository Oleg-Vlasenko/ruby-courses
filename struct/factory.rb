class StructInstance
  def initialize *args
    raise ArgumentError, 'struct size differs' if @@keys.length != args.length

    @struct_data = Hash.new
    args.each_index { |index| @struct_data[@@keys[index]] = args[index] }
  end

  def method_missing (meth, *args)
    is_setter = meth[meth.length - 1] == '='
    key  = is_setter ? meth[0...meth.length - 1].to_sym : meth.to_sym
    raise NoMethodError, "undefined method '" + meth.to_s + "'" unless @struct_data.key?(key)

    if is_setter
      @struct_data[key] = args[0]
    else
      @struct_data[meth]
    end
  end

  def [](key)
    case key.class.to_s
      when 'String'
        raise NameError, "no member '" + key + "' in struct" unless @struct_data.key?(key.to_sym)
        @struct_data[key.to_sym]

      when 'Symbol'
        raise NameError, "no member '" + key.to_s + "' in struct" unless @struct_data.key?(key)
        @struct_data[key]

      when 'Fixnum'
        raise IndexError, "offset " + key.to_s + " too large for struct(size:" + @struct_keys.length.to_s + ")" unless @@keys[key]
        @struct_data[@@keys[key]]

      else
        raise TypeError, 'invalid data type'

    end
  end

  def []=(key, val)
    case key.class.to_s
      when 'String'
        raise NameError, "no member '" + key + "' in struct" unless @struct_data.key?(key.to_sym)
        @struct_data[key.to_sym] = val

      when 'Symbol'
        raise NameError, "no member '" + key.to_s + "' in struct" unless @struct_data.key?(key)
        @struct_data[key] = val

      when 'Fixnum'
        raise IndexError, "offset " + key.to_s + " too large for struct(size:" + @struct_keys.length.to_s + ")" unless @@keys[key]
        @struct_data[@@keys[key]] = val

      else
        raise TypeError, 'invalid data type'

    end
  end

end

class Factory
  def self.new *args, &block
    keys = args.map do |item|
      raise TypeError, 'invalid data type' unless (item.is_a?(String) || item.is_a?(Symbol))
      item.to_sym
    end

    StructInstance.class_variable_set(:@@keys, keys)
    Class.new(StructInstance, &block)
  end
end