#! /usr/bin/ruby

require 'set'

def luckynumbers(a)
  maxs = Set.new
  0.upto(a[0].length - 1) do |x|
    max = [0, 0, 0]
    0.upto(a.length - 1) do |y|
      if a[y][x] > max[0] then
        max = [a[y][x], y, x]
      end
    end
    maxs.add(Marshal.dump(max))
  end
  mins = Set.new
  0.upto(a.length - 1) do |y|
    min = [a[y][0], y, 0]
    0.upto(a[0].length - 1) do |x|
      if a[y][x] < min[0] then
        min = [a[y][x], y, x]
      end
    end
    mins.add(Marshal.dump(min))
  end
  i = (maxs & mins).to_a
  if i.length > 0 then
    return Marshal.load(i[0])[0]
  end
  return -1
end

require 'test/unit'

class TestLuckynumbers < Test::Unit::TestCase

  def test_ex1
    assert_equal(15, luckynumbers([[3, 7, 9], [9, 11, 13], [15, 16, 17]]))
  end

  def test_ex2
    assert_equal(12, luckynumbers([[1, 10, 4, 2], [9, 3, 8, 7], [15, 16, 17, 12]]))
  end

  def test_ex3
    assert_equal(7, luckynumbers([[7, 8], [1, 2]]))
  end

end
