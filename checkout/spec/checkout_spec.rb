require 'rspec'
require 'pry'
require File.dirname(__FILE__) + '/../lib/checkout'

# Item  Price   Offer
# --------------------------
# A     50       3 for 130
# B     30       2 for 45
# C     20
# D     15

RSpec.describe Checkout do

  def price(goods = [])
    pricing_rules = { :a => { :price => 50 },
                      :b => { :price => 30 },
                      :c => { :price => 20 },
                      :d => { :price => 15 },
                      :offers => { :a => { 3 => 130 },
                                   :b => { 2 => 45 } 
                                 }
                    }
    co = Checkout.new(pricing_rules)
    goods.each { |item| co.scan(item) }
    co.total
  end

  it 'costs 0 for no items' do
    expect(price([])).to eq 0
  end

  it 'costs 50 for product A' do
    expect(price(['A'])).to eq 50
  end

  it 'costs 30 for product B' do
    expect(price(['B'])).to eq 30
  end

  it 'costs 20 product C' do
    expect(price(['C'])).to eq 20
  end

  it 'costs 15 for product D' do
    expect(price(['D'])).to eq 15
  end

  it 'costs 80 for products A, B ' do
    expect(price(['A', 'B'])).to eq 80
  end

  it 'costs 115 for products C, D, B, A' do
    expect(price(['C', 'D', 'B', 'A'])).to eq 115
  end

  context 'product A has an offer:' do

    it 'costs 130 for A, A, A' do
      expect(price(['A', 'A', 'A'])).to eq 130
    end

  end

  context 'product B has an offer' do

    it 'costs 45 for B, B' do
      expect(price(['B', 'B'])).to eq 45
    end

  end

  context 'product B and A has an offer' do

    it 'costs 45 for A, A, A, B, B' do
      expect(price(['A', 'A', 'A', 'B', 'B'])).to eq 45
    end

  end

end
