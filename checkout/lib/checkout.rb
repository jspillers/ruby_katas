class Checkout
	attr_reader :pricing_rules
  attr_accessor :cart

  def initialize(pricing_rules)
  	@pricing_rules = pricing_rules
    @cart = []
  end

  def scan(item)
    self.cart << item
  end

  def total
    total = 0
  	@cart.each do |item| 
      if pricing_rules[item.downcase.to_sym]
      total += pricing_rules[item.downcase.to_sym][:price]
      end
    end
    total
  end

end
