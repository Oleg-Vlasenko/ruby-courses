class Addr
  attr_reader :city, :street, :house, :apartment, :destination

  def initialize(city, street, house, apartment, destination)
    @city, @street, @house, @apartment, @destination = city, street, house, apartment, destination
  end
end

class Parcel
  attr_reader :address, :value

  def initialize(address, value)
    @address, @value = address, value
  end

end

class Mail
  def initialize(parcels)
    @parcels = parcels
  end

  def add_parcel(parcel)
    @parcels << parcel
  end

  def parcels_to_city(city)
    count = 0
    @parcels.each { |parcel| count += 1 if parcel.address.city == city }
    count
  end

  def high_val_parcels
    count = 0
    @parcels.each { |parcel| count += 1 if parcel.value > 10}
    count
  end

  def most_popular_address
    addrs = {}
    @parcels.each { |parcel| addrs.key?(parcel.address) ? addrs[parcel.address] += 1 : addrs[parcel.address] = 1 }
    top = addrs.sort_by { |key, val| val }.reverse
    top[0][0]
  end

end

addr1 = Addr.new('Kyiv', 'Shevchenko str', '10', '10', 'Ukraine')
addr2 = Addr.new('Kyiv', 'Gogol str', '20', '6', 'Ukraine')
addr3 = Addr.new('Dnepr', 'Marx prosp', '1', '10', 'Ukraine')
addr4 = Addr.new('Moskow', 'Tverskaya str', '90', '20', 'Russia')

parcels = []
parcels[0] = Parcel.new(addr1, 5)
parcels[1] = Parcel.new(addr1, 15)
parcels[2] = Parcel.new(addr2, 10)
parcels[3] = Parcel.new(addr2, 3)
parcels[4] = Parcel.new(addr2, 30)
parcels[5] = Parcel.new(addr3, 10)
parcels[6] = Parcel.new(addr3, 20)
parcels[7] = Parcel.new(addr4, 20)
parcels[8] = Parcel.new(addr4, 12)

mail = Mail.new(parcels)

p mail.parcels_to_city('Dnepr')
p mail.parcels_to_city('Kyiv')

p mail.high_val_parcels

p mail.most_popular_address