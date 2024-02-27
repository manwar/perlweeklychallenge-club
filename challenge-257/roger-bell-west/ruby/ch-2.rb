#! /usr/bin/ruby

def reducedrowechelon(a)
  leadingone = []
  a.each do |row|
    lp = -1
    row.each_with_index do |cell, cn|
      if cell == 1 then
        lp = cn
        break
      elsif cell != 0 then
        return false
      end
    end
    leadingone.push(lp)
  end
  while leadingone[-1] == -1 do
    leadingone.pop
  end
  c = leadingone.sort
  if c[0] == -1 then
    return false
  end
  if c != leadingone then
    return false
  end
  c.each do |i|
    col = a.map { |r| r[i] }.sort
    if col[-1] != 1 ||
      col[-2] != 0 ||
      col[0] != 0 then
      return false
    end
  end
  return true
end

require 'test/unit'

class TestReducedrowechelon < Test::Unit::TestCase

  def test_ex1
    assert_equal(false, reducedrowechelon([[1, 1, 0], [0, 1, 0], [0, 0, 0]]))
  end

  def test_ex2
    assert_equal(true, reducedrowechelon([[0, 1, -2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]))
  end

  def test_ex3
    assert_equal(true, reducedrowechelon([[1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1]]))
  end

  def test_ex4
    assert_equal(false, reducedrowechelon([[0, 1, -2, 0, 1], [0, 0, 0, 0, 0], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0]]))
  end

  def test_ex5
    assert_equal(false, reducedrowechelon([[0, 1, 0], [0, 1, 0], [0, 0, 0]]))
  end

  def test_ex6
    assert_equal(false, reducedrowechelon([[4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1, -1]]))
  end

  def test_ex7
    assert_equal(false, reducedrowechelon([[1, 0, 0, 4], [1, 0, 0, 7], [0, 0, 1, -1]]))
  end

  def test_ex8
    assert_equal(false, reducedrowechelon([[1, -2, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1]]))
  end

end
