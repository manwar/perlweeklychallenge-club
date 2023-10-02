#! /usr/bin/ruby

def duplicatezeros(a)
  out = []
  a.each do |t|
    out.push(t)
    if t == 0 then
      out.push(t)
    end
    if out.length >= a.length then
      break
    end
  end
  return out[0, a.length]
end

require 'test/unit'

class TestDuplicatezeros < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 0, 0, 2, 3, 0, 0, 4], duplicatezeros([1, 0, 2, 3, 0, 4, 5, 0]))
  end

  def test_ex2
    assert_equal([1, 2, 3], duplicatezeros([1, 2, 3]))
  end

  def test_ex3
    assert_equal([0, 0, 3, 0, 0], duplicatezeros([0, 3, 0, 4, 5]))
  end

end
