#! /usr/bin/ruby

require 'set'

def arrayloops(a)
  loop_id = 0
  loops = Hash.new
  0.upto(a.length - 1) do |origin|
    if !loops.has_key?(origin) then
      li = 0
      thisloop = Set.new
      x = origin
      while true do
        if x < 0 or x >= a.length then
          break
        end
        thisloop.add(x)
        x = a[x]
        if loops.has_key?(x) then
          li = loops[x]
          break
        end
        if thisloop.include?(x) then
          loop_id += 1
          li = loop_id
          break
        end
      end
      thisloop.each do |i|
        loops[i] = li
      end
    end
  end
  return loop_id
end

require 'test/unit'

class TestArrayloops < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, arrayloops([4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9, 10]))
  end

  def test_ex2
    assert_equal(6, arrayloops([0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19]))
  end

  def test_ex3
    assert_equal(1, arrayloops([9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6, 17]))
  end

end
