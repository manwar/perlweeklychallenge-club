#! /usr/bin/ruby

require 'set'

def ballsandboxes(a)
  boxes = Hash.new
  colour = '@'
  a.chars.each_with_index do |c, i|
    if i % 2 == 0
      colour = c
    else
      boxid = c.to_i
      if boxes.has_key?(boxid)
        boxes[boxid].add(colour)
      else
        boxes[boxid] = Set.new([colour])
      end
    end
  end
  boxes.values.filter{|x| x.length >= 3}.length
end

require 'test/unit'

class TestBallsandboxes < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, ballsandboxes('G0B1R2R0B0'))
  end

  def test_ex2
    assert_equal(3, ballsandboxes('G1R3R6B3G6B1B6R1G3'))
  end

  def test_ex3
    assert_equal(0, ballsandboxes('B3B2G1B3'))
  end

end
