#! /usr/bin/ruby

def likenumber(source,factor)
  s=source.to_s.split('').map {|i| i.to_i}
  m=s.length
  n=0
  1.upto((1<<m)-2) do |mask|
    c=0
    0.upto(m-1) do |di|
      if (mask & 1<<di)>0 then
        c=c*10+s[di]
      end
    end
    if c % factor == 0 then
      n+=1
    end
  end
  return n
end

require 'test/unit'

class TestLikenumber < Test::Unit::TestCase

  def test_ex1
    assert_equal(9,likenumber(1234,2))
  end

  def test_ex2
    assert_equal(3,likenumber(768,4))
  end

end
