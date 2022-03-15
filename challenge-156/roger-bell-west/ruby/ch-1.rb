#! /usr/bin/ruby

require 'test/unit'

require 'prime'

def hammingweight(x0)
  x=x0
  count=0
  while x > 0 do
    x &= x-1
    count += 1
  end
  return count
end

def pernicious(n)
  out=[]
  c=1
  while true do
    if hammingweight(c).prime? then
      out.push(c)
      if out.length >= n then
        break
      end
    end
    c += 1
  end
  return out
end

class TestPernicious < Test::Unit::TestCase

  def test_ex1
    assert_equal([3, 5, 6, 7, 9, 10, 11, 12, 13, 14],pernicious(10))
  end

end
