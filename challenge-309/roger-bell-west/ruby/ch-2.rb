#! /usr/bin/ruby

def mindiff(a)
  md = 0
  n = false
  0.upto(a.length - 2) do |i|
    (i + 1).upto(a.length - 1) do |j|
      diff = (a[i] - a[j]).abs
      if !n || diff < md
        md = diff
        n = true
      end
    end
  end
  md
end
  
require 'test/unit'

class TestMindiff < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, mindiff([1, 5, 8, 9]))
  end

  def test_ex2
    assert_equal(2, mindiff([9, 4, 1, 7]))
  end

end
