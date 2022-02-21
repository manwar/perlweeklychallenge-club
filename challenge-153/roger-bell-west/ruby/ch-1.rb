#! /usr/bin/ruby

require 'test/unit'

def leftfactorial(mx)
  out=[]
  fact=1
  sum=0
  0.upto(mx-1) do |i|
    if i > 0 then
      fact *= i
    end
    sum += fact
    out.push(sum)
  end
  return out
end

class TestLeftfactorial < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114],leftfactorial(10))
  end

end
