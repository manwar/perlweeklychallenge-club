#! /usr/bin/ruby

def ri(s)
  r=s.to_s.reverse
  if r =~ /([0-9]+)-$/
    r='-' + $1
  end
  r=Integer(r)
  b=[r].pack('l').unpack('l')[0]
  if b != r
    return 0
  end
  return r
end

require 'test/unit'

class TestRi < Test::Unit::TestCase

  def test_ex1
    assert_equal(4321,ri(1234),'example 1')
  end

  def test_ex2
    assert_equal(-4321,ri(-1234),'example 2')
  end

  def test_ex3
    assert_equal(0,ri(1231230512),'example 3')
  end

end
