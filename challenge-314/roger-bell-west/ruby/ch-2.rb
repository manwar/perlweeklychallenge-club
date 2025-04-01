#! /usr/bin/ruby

def sortcolumn(a)
  vv = Array.new
  a.each_with_index do |s, i|
    s.chars.each_with_index do |c, j|
      if i == 0
        vv.push(Array.new)
      end
      vv[j].push(c)
    end
  end
  tot = 0
  vv.each do |x|
    y = x.sort
    if x != y
      tot += 1
    end
  end
  tot
end

require 'test/unit'

class TestSortcolumn < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, sortcolumn(['swpc', 'tyad', 'azbe']))
  end

  def test_ex2
    assert_equal(1, sortcolumn(['cba', 'daf', 'ghi']))
  end

  def test_ex3
    assert_equal(0, sortcolumn(['a', 'b', 'c']))
  end

end
