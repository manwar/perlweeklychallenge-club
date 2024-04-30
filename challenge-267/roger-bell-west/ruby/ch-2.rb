#! /usr/bin/ruby

def linecounts(a, w)
  linecount = 1
  linewidth = 0
  asize = 'a'.ord()
  a.split('').each do |c|
    wd = w[c.ord() - asize]
    if linewidth + wd > 100 then
      linecount += 1
      linewidth = wd
    else
      linewidth += wd;
    end
  end
  return [linecount, linewidth]
end

require 'test/unit'

class TestLinecounts < Test::Unit::TestCase

  def test_ex1
    assert_equal([3, 60], linecounts('abcdefghijklmnopqrstuvwxyz', [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]))
  end

  def test_ex2
    assert_equal([2, 4], linecounts('bbbcccdddaaa', [4, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]))
  end

end
