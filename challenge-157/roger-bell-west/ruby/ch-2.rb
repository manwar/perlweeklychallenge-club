#! /usr/bin/ruby

require 'test/unit'

def brazilian(n)
  2.upto(n-2) do |b|
    nn = n
    braz = true
    digit = nn % b
    while nn > 0 do
      if digit == nn % b then
        nn /= b
      else
        braz = false
        break
      end
    end
    if braz then
      return true
    end
  end
  return false
end

class TestBrazilian < Test::Unit::TestCase

  def test_ex1
    assert_equal(true,brazilian(7))
  end

  def test_ex2
    assert_equal(false,brazilian(6))
  end

  def test_ex3
    assert_equal(true,brazilian(8))
  end

end
