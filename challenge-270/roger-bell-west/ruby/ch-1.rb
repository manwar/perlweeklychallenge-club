#! /usr/bin/ruby

require 'set'

def validator(a0)
  a = a0.sort
  l = a.size
  if a[0] == 0  && a[l - 2] == 0 && a[l - 1] == 1
    (0 ... l).each do |i|
      if a0[i] == 1
        return i
      end
    end
  end
  nil
end

def specialpositions(a)
  vr = Array.new
  xs = Set.new
  a.each_with_index do |row, y|
    x = validator(row) || -1
    if x
      vr.push([y, x])
      xs.add(x)
    end
  end
  xd = Set.new
  xs.each do |x|
    c = a.map { |r| r[x] }
    unless validator(c)
      xd.add(x)
    end
  end
  xs -= xd
  vr.select { | y, x | xs.include?(x) }.size
end

require 'test/unit'

class TestSpecialpositions < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, specialpositions([[1, 0, 0], [0, 0, 1], [1, 0, 0]]))
  end

  def test_ex2
    assert_equal(3, specialpositions([[1, 0, 0], [0, 1, 0], [0, 0, 1]]))
  end

end
