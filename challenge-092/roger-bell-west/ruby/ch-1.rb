#! /usr/bin/ruby

def isos(a,b)
  if a.length != b.length
    return 0
  end
  s=[a,b]
  lt=[Hash.new,Hash.new]
  n=[0,0]
  0.upto(a.length-1) do |ci|
    r=Array.new
    0.upto(1) do |si|
      if lt[si].has_key?(s[si][ci])
        r.push(lt[si][s[si][ci]])
      else
        lt[si][s[si][ci]]=n[si]
        r.push(n[si])
        n[si]+= 1
      end
    end
    if r[0] != r[1]
      return 0
    end
  end
  return 1
end

require 'test/unit'

class TestIsos < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,isos('abc','xyz'))
  end

  def test_ex2
    assert_equal(1,isos('abb','xyy'))
  end

  def test_ex3
    assert_equal(0,isos('sum','add'))
  end

end
