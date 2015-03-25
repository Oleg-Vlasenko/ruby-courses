class Test < ActiveRecord::Base
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'

  has_many :orders
  
  before_destroy  :indexes_must_be_empty
  #validate :indexes_must_be_empty

  private
  
  def get_idx(index_name)
    self.send(index_name)
  end
  
  def get_indexes
    # self.public_methods.grep(/before_add_for\w+\?$/).map { |item| item.to_s.gsub!(/before_add_for_/, '').gsub!(/\?$/, '') }
    self.class.reflect_on_all_associations(:has_many).map{ |item| item.klass.to_s }
  end
  
  def indexes_must_be_empty
    result = true
    idxs = get_indexes
    idxs.each do |idx|
      if get_idx(idx)
        result = false
        self.errors.add(idx, "#{idx} is not empty!")
      end
    end
    
    return result
  end
  
end
