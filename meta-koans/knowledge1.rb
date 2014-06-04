
class Class
  #def attribute attr_name
  #  instance_variable_set %Q{@#{attr_name}}, ''
  #  instance_eval %Q{ attr_accessor :#{attr_name} }
  #  class_eval %Q{ def #{attr_name}?
  #    instance_variable_get(%Q{@#{attr_name}})
  #  end }
  #  def test
  #    p 'test'
  #  end
  #end
end

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
      if block_given?
        #define_method(%Q{:#{block}})
        val = instance_eval(&block)
      else
        val = 0
      end

      self.create_attr(attr, val)
    end
  end

  def method_missing meth
    module_eval(%Q{def #{meth}
      end})
  end
end

#ml = Module::new {
#  attribute 'a'
#}
#
#m = Class::new {
#  include ml
#  extend ml
#}
#
#o = m::new
#
#p '0' unless o.a?
#p o.a = 42
#p o.a == 42
#p '0' unless o.a?
#
#p '0' unless m.a?
#p m.a = 42
#p m.a == 42
#p '0' unless m.a?

c = Class::new {
  attribute('a'){ fortytwo }
  def fortytwo
    42
  end
}

o = c::new

p '0' unless o.a?
#p o.a = 42
p o.a == 42
p '0' unless o.a?

p Class.ancestors


# 'attribute' must provide getter, setter, and query to modules at module
# level
#
def koan_3
end
#
# 'attribute' must provide getter, setter, and query to modules which operate
# correctly when they are included by or extend objects
#
def koan_4
end
#
# 'attribute' must provide getter, setter, and query to singleton objects
#
def koan_5
  o = Object::new

  class << o
    attribute 'a'
  end

  assert{ not o.a? }
  assert{ o.a = 42 }
  assert{ o.a == 42 }
  assert{ o.a? }
end
#
# 'attribute' must provide a method for providing a default value as hash
#
def koan_6
  c = Class::new {
    attribute 'a' => 42
  }

  o = c::new

  assert{ o.a == 42 }
  assert{ o.a? }
  assert{ (o.a = nil) == nil }
  assert{ not o.a? }
end
#
# 'attribute' must provide a method for providing a default value as block
# which is evaluated at instance level
#
def koan_7
  c = Class::new {
    attribute('a'){ fortytwo }
    def fortytwo
      42
    end
  }

  o = c::new

  assert{ o.a == 42 }
  assert{ o.a? }
  assert{ (o.a = nil) == nil }
  assert{ not o.a? }
end
#
# 'attribute' must provide inheritance of default values at both class and
# instance levels
#
def koan_8
  b = Class::new {
    class << self
      attribute 'a' => 42
      attribute('b'){ a }
    end
    attribute 'a' => 42
    attribute('b'){ a }
  }

  c = Class::new b

  assert{ c.a == 42 }
  assert{ c.a? }
  assert{ (c.a = nil) == nil }
  assert{ not c.a? }

  o = c::new

  assert{ o.a == 42 }
  assert{ o.a? }
  assert{ (o.a = nil) == nil }
  assert{ not o.a? }
end
#
# into the void
#
def koan_9
  b = Class::new {
    class << self
      attribute 'a' => 42
      attribute('b'){ a }
    end
    include Module::new {
      attribute 'a' => 42
      attribute('b'){ a }
    }
  }

  c = Class::new b

  assert{ c.a == 42 }
  assert{ c.a? }
  assert{ c.a = 'forty-two' }
  assert{ c.a == 'forty-two' }
  assert{ b.a == 42 }

  o = c::new

  assert{ o.a == 42 }
  assert{ o.a? }
  assert{ (o.a = nil) == nil }
  assert{ not o.a? }
end

#c = Class.new {
#  p 'class.new is called'
#  attribute 'a'
#}
#
#p c
#c.a = 42
#p c.a
#p c.a?
