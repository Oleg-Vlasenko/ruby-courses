class Test
  
  
  def a
    puts 'a'
  end
  
  def b
    a
  end
  
  def c
    @a = 10
    self.a
  end
  
  def get_a
    @a
  end

  def get_a2
    self
  end
end

t = Test.new
puts 't.b'
t.b
puts 't.c'
t.c

t.get_a
p t.get_a2
t.a
