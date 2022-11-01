#! /usr/bin/ruby

require 'test/unit'

def arraydegree(a)
  f = Hash.new(0)
  a.each do |x|
    f[x] += 1
  end
  degree = f.values.max
  inverse = Hash.new()
  a.each_with_index do |x, i|
    if !inverse.has_key?(x) then
      inverse[x] = []
    end
    inverse[x].push(i)
  end
  minlen = 1 + a.length
  se = [0, 1]
  f.keys.find_all {|x| f[x] == degree}.each do |n|
    ll = 1 + inverse[n][-1] - inverse[n][0]
    if ll < minlen then
      minlen = ll
      se = [inverse[n][0],inverse[n][-1]]
    end
  end
  return a[se[0]..se[1]]
end

class TestArraydegree < Test::Unit::TestCase

  def test_ex1
    assert_equal([3, 3], arraydegree([1, 3, 3, 2]));
  end

  def test_ex2
    assert_equal([1, 2, 1], arraydegree([1, 2, 1, 3]));
  end

  def test_ex3
    assert_equal([2, 1, 2], arraydegree([1, 3, 2, 1, 2]));
  end

  def test_ex4
    assert_equal([1, 1], arraydegree([1, 1, 2, 3, 2]));
  end

  def test_ex5
    assert_equal([1, 2, 1, 1], arraydegree([2, 1, 2, 1, 1]));
  end
end
