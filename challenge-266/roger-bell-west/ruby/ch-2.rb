#! /usr/bin/ruby

require 'test/unit'

def xmatrix(a)
  order = a.length - 1
  valid = true
  a.each_with_index do |row, y|
    row.each_with_index do |value, x|
      if x == y || x == order - y then
        if value == 0 then
          valid = false
        end
      else
        if value != 0 then
          valid = false
        end
      end
      if !valid then
        break
      end
    end
    if !valid then
      break
    end
  end
  return valid
end

class TestXmatrix < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, xmatrix([[1, 0, 0, 2], [0, 3, 4, 0], [0, 5, 6, 0], [7, 0, 0, 1]]))
  end

  def test_ex2
    assert_equal(false, xmatrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
  end

  def test_ex3
    assert_equal(true, xmatrix([[1, 0, 2], [0, 3, 0], [4, 0, 5]]))
  end

end
