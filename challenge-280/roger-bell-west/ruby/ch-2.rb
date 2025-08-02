#! /usr/bin/ruby

def countasterisks(a)
  out = 0
  active = true
  a.chars.each do |c|
    case c
    when '|'
      active = !active
    when '*'
      if active
        out += 1
      end
    end
  end
  out
end

require 'test/unit'

class TestCountasterisks < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, countasterisks('p|*e*rl|w**e|*ekly|'))
  end

  def test_ex2
    assert_equal(0, countasterisks('perl'))
  end

  def test_ex3
    assert_equal(5, countasterisks('th|ewe|e**|k|l***ych|alleng|e'))
  end

end
