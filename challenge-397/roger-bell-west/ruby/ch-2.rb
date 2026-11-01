#! /usr/bin/ruby

def reflect(a)
  p = []
  am = a
  while true do
    p.push(am % 2)
    am >>= 1
    if am == 0
      break
    end
  end
  ar = 0
  s = p.length
  p.each do |n|
    s -= 1
    ar += n << s
  end
  ar
end

def binaryreflection(ax)
  k = ax.map{|x| reflect(x)}
  i = 0.upto(ax.length - 1).to_a
  i.sort! do |a, b|
    if k[a] == k[b]
      ax[a] <=> ax[b]
    else
      k[a] <=> k[b]
    end
  end
  i.map{|x| ax[x]}
end

require 'test/unit'

class TestBinaryreflection < Test::Unit::TestCase

  def test_ex1
    assert_equal([3, 6, 12], binaryreflection([3, 6, 12]))
  end

  def test_ex2
    assert_equal([1, 2, 4, 8], binaryreflection([1, 2, 4, 8]))
  end

  def test_ex3
    assert_equal([8, 10, 7, 9], binaryreflection([7, 8, 9, 10]))
  end

  def test_ex4
    assert_equal([5, 9, 15, 17], binaryreflection([5, 9, 15, 17]))
  end

  def test_ex5
    assert_equal([14, 13, 11, 19], binaryreflection([11, 13, 14, 19]))
  end

end
