#! /usr/bin/ruby

def hisb(n)
  s='0' + sprintf('%b',n)
  s =~ /^(.*?)01(1*0*)$/
  a=$1
  c=$2
  t0=c.gsub(/1/,"")
  t1=c.gsub(/0/,"")
  return (a + '10' + t0 + t1).to_i(2)
end

require 'test/unit'

class TestHisb < Test::Unit::TestCase

  def test_ex1
    assert_equal(5,hisb(3))
  end
  
  def test_ex2
    assert_equal(17,hisb(12))
  end
  
end
