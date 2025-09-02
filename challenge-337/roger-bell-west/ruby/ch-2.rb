#! /usr/bin/ruby

require 'set'

def oddmatrix(rows, cols, points)
  rm = Set.new
  cm = Set.new
  points.each do |p|
    if rm.includes?(p[0])
      rm.delete(p[0])
    else
      rm.add(p[0])
    end
    if cm.includes?(p[1])
      cm.delete(p[1])
    else
      cm.add(p[1])
    end
  end
  rm.size * (cols - cm.size) +
        cm.size * (rows - rm.size)
end

def oddmatrix(rows, cols, points)
  mx = []
  1.upto(rows) do |r|
    row = []
    1.upto(cols) do |c|
      row.push(0)
    end
    mx.push(row)
  end
  points.each do |p|
    0.upto(rows - 1) do |x|
      mx[x][p[1]] += 1
    end
    0.upto(cols - 1) do |y|
      mx[p[0]][y] += 1
    end
  end
  mx.map{|x| x.filter{|y| y % 2 == 1}.length}.sum
end

require 'test/unit'

class TestOddmatrix < Test::Unit::TestCase

  def test_ex1
    assert_equal(6, oddmatrix(2, 3, [[0, 1], [1, 1]]))
  end

  def test_ex2
    assert_equal(0, oddmatrix(2, 2, [[1, 1], [0, 0]]))
  end

  def test_ex3
    assert_equal(0, oddmatrix(3, 3, [[0, 0], [1, 2], [2, 1]]))
  end

  def test_ex4
    assert_equal(2, oddmatrix(1, 5, [[0, 2], [0, 4]]))
  end

  def test_ex5
    assert_equal(8, oddmatrix(4, 2, [[1, 0], [3, 1], [2, 0], [0, 1]]))
  end

end
