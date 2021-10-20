#! /usr/bin/ruby

def sedolv(sedol)
  if sedol.length() != 7 then
    return 0
  end
  w=[1,3,1,7,3,9,1]
  s=0
  sedol.split("").zip(w).each do |x|
    n=0
    if x[0].match(/[[:digit:]]/) then
      n=x[0].to_i()
    elsif x[0].match(/[[:alpha:]]/) && x[0].match(/[[:upper:]]/) &&
          ! "AEIOU".include?(x[0]) then
      n=x[0].ord()-55
    else
      return 0
    end
    s+=n*x[1]
  end
  if s % 10 == 0 then
    return 1
  end
  return 0
end

require 'test/unit'

class TestSedolv < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,sedolv('2936921'))
  end
  
  def test_ex2
    assert_equal(0,sedolv('1234567'))
  end
  
  def test_ex3
    assert_equal(1,sedolv('B0YBKL9'))
  end
  
  def test_ex4
    assert_equal(0,sedolv('A0ZBKL9'))
  end
  
  def test_ex5
    assert_equal(0,sedolv('B2YBIL9'))
  end
  
  
end
