#! /usr/bin/ruby

require 'set'

def validatecoupon(codes, names, status)
  rx = Regexp.new("^[0-9A-Za-z_]+$")
  dep = Set.new(["electronics", "grocery", "pharmacy", "restaurant"])
  0.upto(codes.length - 1).map { |i| !(codes[i] =~ rx).nil? && dep.include?(names[i]) && status[i] }
end

require 'test/unit'

class TestValidatecoupon < Test::Unit::TestCase

  def test_ex1
    assert_equal([true, false, true, false, true], validatecoupon(['A123', 'B_456', 'C789', 'D@1', 'E123'], ['electronics', 'restaurant', 'electronics', 'pharmacy', 'grocery'], [true, false, true, true, true]))
  end

  def test_ex2
    assert_equal([true, true, false, true, false], validatecoupon(['Z_9', 'AB_12', 'G01', 'X99', 'test'], ['pharmacy', 'electronics', 'grocery', 'electronics', 'unknown'], [true, true, false, true, true]))
  end

  def test_ex3
    assert_equal([true, true, false, true, true], validatecoupon(['_123', '123', '', 'Coupon_A', 'Alpha'], ['restaurant', 'electronics', 'electronics', 'pharmacy', 'grocery'], [true, true, false, true, true]))
  end

  def test_ex4
    assert_equal([true, true, true, true], validatecoupon(['ITEM_1', 'ITEM_2', 'ITEM_3', 'ITEM_4'], ['electronics', 'electronics', 'grocery', 'grocery'], [true, true, true, true]))
  end

  def test_ex5
    assert_equal([true, true, true, true, false], validatecoupon(['CAFE_X', 'ELEC_100', 'FOOD_1', 'DRUG_A', 'ELEC_99'], ['restaurant', 'electronics', 'grocery', 'pharmacy', 'electronics'], [true, true, true, true, false]))
  end

end
