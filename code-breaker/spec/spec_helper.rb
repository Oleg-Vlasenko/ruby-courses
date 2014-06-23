RSpec::Matchers.define :have do |count|
  chain :items do
    @result
  end

  match do |items|
    @result = items.length == count
  end
end

RSpec::Matchers.define :in_range do |min, max|
  match do |items|
    items.each { |item| return false unless item.between?(min, max) }
    true
  end
  end

RSpec::Matchers.define :in_array do |arr|
  match { |item| arr.include?(item) }
end