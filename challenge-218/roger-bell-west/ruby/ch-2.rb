#! /usr/bin/ruby

def matrixscore(matrix0)
  matrix = matrix0
  0.upto(matrix.length-1) do |i|
    if matrix[i][0] == 0 then
      0.upto(matrix[i].length-1) do |j|
        matrix[i][j] = 1 - matrix[i][j]
      end
    end
  end
  t = matrix.length.div(2)
  1.upto(matrix[0].length-1) do |i|
    c = 0
    0.upto(matrix.length-1) do |j|
      if matrix[j][i] == 0 then
        c += 1
        end
    end
    if c > t then
      0.upto(matrix.length-1) do |j|
        matrix[j][i] = 1 - matrix[j][i]
      end
    end
  end
  tot = 0
  matrix.each do |m|
    p = 0
    m.each do |n|
      p *= 2
      if n == 1 then
        p += 1
      end
    end
    tot += p
  end
  return tot
end

require 'test/unit'

class TestMatrixscore < Test::Unit::TestCase

  def test_ex1
    assert_equal(39, matrixscore([[0, 0, 1, 1], [1, 0, 1, 0], [1, 1, 1, 0]]))
  end

  def test_ex2
    assert_equal(1, matrixscore([[0]]))
  end

end
