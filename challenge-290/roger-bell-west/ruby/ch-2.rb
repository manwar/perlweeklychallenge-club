#! /usr/bin/ruby

def luhnalgorithm(a)
  digits = a.chars.select{|x| x >= '0' && x <= '9'}.map{|x| x.to_i}
  payload = digits.pop
  digits = digits.reverse
  0.step(to: digits.size - 1, by: 2) do |i|
    digits[i] *= 2
    if digits[i] > 9
      digits[i] -= 9
    end
  end
  10 - (digits.sum() % 10) == payload
end

require 'test/unit'

class TestLuhnalgorithm < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, luhnalgorithm('17893729974'))
  end

  def test_ex2
    assert_equal(true, luhnalgorithm('4137 8947 1175 5904'))
  end

  def test_ex3
    assert_equal(false, luhnalgorithm('4137 8974 1175 5904'))
  end

end
