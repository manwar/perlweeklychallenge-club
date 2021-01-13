#! /usr/bin/ruby

def cn(n)
  j=n.scan(/((.)\2*)/)
  out=Array.new
  j.each do |x|
    out.push(x[0].length)
    out.push(x[1])
  end
  return out.join
end

require 'test/unit'

class TestCn < Test::Unit::TestCase

  def test_ex1
    assert_equal('21321314',cn('1122234'))
  end

  def test_ex2
    assert_equal('12332415',cn('2333445'))
  end

  def test_ex3
    assert_equal('1112131415',cn('12345'))
  end

end
