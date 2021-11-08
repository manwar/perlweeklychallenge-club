#! /usr/bin/ruby

def m3d(n)
  m=n.abs().to_s()
  l=m.length()
  if l<3 then
    return "too short"
  end
  if l%2 == 0 then
    return "even number of digits"
  end
  return m[l/2-1,3]
end

require 'test/unit'

class TestM3d < Test::Unit::TestCase

  def test_ex1
    assert_equal("345",m3d(1234567))
  end

  def test_ex2
    assert_equal("123",m3d(-123))
  end

  def test_ex3
    assert_equal("too short",m3d(1))
  end

  def test_ex4
    assert_equal("even number of digits",m3d(1010))
  end

end
