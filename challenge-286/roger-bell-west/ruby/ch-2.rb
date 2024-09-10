#! /usr/bin/ruby

def ordergame(a)
  p = a
  while p.size > 1
    q = []
    mm = true
    p.each_slice(2) do |j|
      if mm
        q.push(j.min)
      else
        q.push(j.max)
      end
      mm = !mm
    end
    p = q
  end
  p[0]
end

require 'test/unit'

class TestOrdergame < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, ordergame([2, 1, 4, 5, 6, 3, 0, 2]))
  end

  def test_ex2
    assert_equal(0, ordergame([0, 5, 3, 2]))
  end

  def test_ex3
    assert_equal(2, ordergame([9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]))
  end

end
