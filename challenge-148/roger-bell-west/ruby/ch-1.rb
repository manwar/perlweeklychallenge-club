#! /usr/bin/ruby

require 'test/unit'

def eban(mx)
  units=[true,false,true,false,true,false,true,false,false,false]
  tens=[true,false,false,true,true,true,true,false,false,false,false]
  out=[]
  0.upto(mx) do |i|
    if tens[(i/10).to_i] and units[i%10] and i!=0 then
      out.push(i)
    end
  end
  return out
end

class TestEban < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 4, 6, 30, 32, 34, 36, 40, 42, 44, 46, 50, 52, 54, 56, 60, 62, 64, 66],eban(100))
  end

end
