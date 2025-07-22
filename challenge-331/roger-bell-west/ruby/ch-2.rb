#! /usr/bin/ruby

def buddystrings(a, b)
  ac = a.chars
  bc = b.chars
  0.upto(ac.size - 1) do |i|
    (i + 1).upto(ac.size - 1) do |j|
      acx = ac.clone
      acx[i] = ac[j]
      acx[j] = ac[i]
      if acx == bc
        return true
      end
    end
  end
  false
end

require 'test/unit'

class TestBuddystrings < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, buddystrings('fuck', 'fcuk'))
  end

  def test_ex2
    assert_equal(false, buddystrings('love', 'love'))
  end

  def test_ex3
    assert_equal(true, buddystrings('fodo', 'food'))
  end

  def test_ex4
    assert_equal(true, buddystrings('feed', 'feed'))
  end

end
