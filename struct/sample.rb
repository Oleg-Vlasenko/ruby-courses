require './Factory.rb'

Customer = Factory.new(:name, :address, :zip) do
  def greeting
    "Hello #{name}!"
  end
end

joe = Customer.new('Joe Smith', '123 Maple, Anytown NC', 12345)
p joe.name
p joe['name']
p joe[:name]
p joe[0]

joe.name = 'Dan'
p joe.name

joe[:name] = 'Dave'
p joe[:name]

p joe.greeting