#! /usr/bin/ruby

def dvalue(a)
  if a[0] < a[1]
    a[0] * 64 + a[1]
  else 
    a[0] + a[1] * 64
  end
end

def counterify(a)
  cc = Hash.new
  cc.default = 0
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def similardominoes(a)
  c = counterify(a.map { |x| dvalue(x) })
  t = 0
  c.values.each do |v|
    if v > 1
      t += v
    end
  end
  t
end

require 'test/unit'

class TestSimilardominoes < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, similardominoes([[1, 3], [3, 1], [2, 4], [6, 8]]))
  end

  def test_ex2
    assert_equal(3, similardominoes([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]]))
  end

end
