#! /usr/bin/ruby

require 'set'

def squared(a)
  return a * a
end

def squareful(lst)
  results = Set.new
  squares = Set.new
  lst.permutation do |la|
    squareful = true
    la.each_cons(2) do |a|
      cs = a[0] + a[1]
      mx = squared(squares.length)
      while cs > mx do
        mx = squared(squares.length + 1)
        squares.add(mx)
      end
      if !squares.include?(cs) then
        squareful = false
        break
      end
    end
    if squareful then
      results.add(la)
    end
  end
  return results.to_a.sort
end

require 'test/unit'

class TestSquareful < Test::Unit::TestCase

  def test_ex1
    assert_equal([[1, 8, 17], [17, 8, 1]], squareful([1, 17, 8]))
  end

  def test_ex2
    assert_equal([[2, 2, 2]], squareful([2, 2, 2]))
  end

end
