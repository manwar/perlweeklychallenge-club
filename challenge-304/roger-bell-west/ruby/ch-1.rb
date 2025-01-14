#! /usr/bin/ruby

def arrangebinary(a, n)
  b = a.clone
  t = n
  0.upto(b.size - 1) do |i|
    if b[i] == 0 &&
       (i == 0 || b[i - 1] == 0) &&
       (i == b.size - 1 || b[i + 1] == 0)
      b[i] = 1
      t -= 1
      if t == 0
        break
      end
    end
  end
  t == 0
end

require 'test/unit'

class TestArrangebinary < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, arrangebinary([1, 0, 0, 0, 1], 1))
  end

  def test_ex2
    assert_equal(false, arrangebinary([1, 0, 0, 0, 1], 2))
  end

end
