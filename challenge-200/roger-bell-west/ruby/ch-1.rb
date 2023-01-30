#! /usr/bin/ruby

require 'test/unit'

def arithmeticslices(l)
  o = []
  if l.length >= 3 then
    0.upto(l.length - 3) do |a|
      valid = false
      (a + 2).upto(l.length - 1) do |b|
        v = l[a..b]
        if !valid then
          0.upto(v.length - 3) do |i|
            if v[i + 1] - v[i] == v[i + 2] - v[i + 1] then
              valid = true
              break
            end
          end
        end
        if valid then
          o.push(v)
        end
      end
    end
  end
  return o
end

class TestArithmeticslices < Test::Unit::TestCase

  def test_ex1
    assert_equal([[1, 2, 3], [1, 2, 3, 4], [2, 3, 4]], arithmeticslices([1, 2, 3, 4]))
  end

  def test_ex2
    assert_equal([], arithmeticslices([2]))
  end

end
