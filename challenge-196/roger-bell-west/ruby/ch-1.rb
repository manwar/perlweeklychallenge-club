#! /usr/bin/ruby

require 'test/unit'

def pattern132(l)
  o = []
  0.upto(l.length-3) do |a|
    (a+1).upto(l.length-2) do |b|
      if l[a] < l[b] then
        (b+1).upto(l.length-1) do |c|
          if l[b] > l[c] && l[a] < l[c] then
            o = [l[a], l[b], l[c]]
            break
          end
        end
      end
      if o.length > 0 then
        break
      end
    end
    if o.length > 0 then
      break
    end
  end
  return o
end

class TestPattern132 < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 4, 2], pattern132([3, 1, 4, 2]))
  end

  def test_ex2
    assert_equal([], pattern132([1, 2, 3, 4]))
  end

  def test_ex3
    assert_equal([1, 3, 2], pattern132([1, 3, 2, 4, 6, 5]))
  end

  def test_ex4
    assert_equal([1, 3, 2], pattern132([1, 3, 4, 2]))
  end
end
