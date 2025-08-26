#! /usr/bin/ruby

require 'set'

def counterify(a)
  cc = Hash.new
  cc.default = 0
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def equalgroup(a)
  s = counterify(a)
  v = s.values.to_set.to_a.sort
  l = v[0]
  if l < 2
    return false
  end
  2.upto(l) do |t|
    if v.all? { |c| c % t == 0 }
      return true
    end
  end
  false
end

require 'test/unit'

class TestEqualgroup < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, equalgroup([1, 1, 2, 2, 2, 2]))
  end

  def test_ex2
    assert_equal(false, equalgroup([1, 1, 1, 2, 2, 2, 3, 3]))
  end

  def test_ex3
    assert_equal(true, equalgroup([5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7]))
  end

  def test_ex4
    assert_equal(false, equalgroup([1, 2, 3, 4]))
  end

  def test_ex5
    assert_equal(true, equalgroup([8, 8, 9, 9, 10, 10, 11, 11]))
  end

end
