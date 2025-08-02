#! /usr/bin/ruby

def productsign(a)
  out = 1
  a.each do |t|
    if t < 0 then
      out = -out
    elsif t == 0
      out = 0
      break
    end
  end
  return out
end

require 'test/unit'

class TestProductsign < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, productsign([-1, -2, -3, -4, 3, 2, 1]))
  end

  def test_ex2
    assert_equal(0, productsign([1, 2, 0, -2, -1]))
  end

  def test_ex3
    assert_equal(-1, productsign([-1, -1, 1, -1, 2]))
  end

end
