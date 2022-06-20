#! /usr/bin/ruby

require 'test/unit'

require 'prime'

def primorial(ct)
  o = [1]
  Prime.each do |p|
    o.push(p * o[-1])
    if o.length >= ct then
      break
    end
  end
  return o
end

class TestPrimorial < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 2, 6, 30, 210],primorial(5))
  end

  def test_ex2
    assert_equal([1, 2, 6, 30, 210, 2310, 30030, 510510, 9699690,
                  223092870],primorial(10))
  end

end
