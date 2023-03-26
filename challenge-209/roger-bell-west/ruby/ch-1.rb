#! /usr/bin/ruby

require 'test/unit'

def specialbitcharacters(a)
  s = 0
  a.each do |v|
    if s == 1 then
      s = 2
    else
      s = v
    end
  end
  return s == 0
end

class TestSpecialbitcharacters < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, specialbitcharacters([1, 0, 0]))
  end

  def test_ex2
    assert_equal(false, specialbitcharacters([1, 1, 1, 0]))
  end

end
