#! /usr/bin/ruby

def ca(n)
  a=0
  p=Regexp.new("([0-9]+):([0-9]+)")
  if n =~ /([0-9]+):([0-9]+)/ then
    hh=$1.to_f
    mm=$2.to_f
    hm=[hh*30+mm/2,mm*6].map {|i| i % 360}
    a=(hm[0]-hm[1]).abs
    while (a > 180) do
      a-=360;
    end
    a=a.abs
  end
  return a;
end

require 'test/unit'

class TestCa < Test::Unit::TestCase

  def test_ex1
    assert_equal(35,ca('03:10'))
  end
  
  def test_ex2
    assert_equal(120,ca('04:00'))
  end
  
end
