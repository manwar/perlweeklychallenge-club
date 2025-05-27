#! /usr/bin/ruby

def incrementdecrement(operations)
  p = 0
  operations.each do |s|
    if s.chars()[1] == "+"
      p += 1
    else
      p -= 1
    end
  end
  p
end

require 'test/unit'

class TestIncrementdecrement < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, incrementdecrement(['--x', 'x++', 'x++']))
  end

  def test_ex2
    assert_equal(3, incrementdecrement(['x++', '++x', 'x++']))
  end

  def test_ex3
    assert_equal(0, incrementdecrement(['x++', '++x', '--x', 'x--']))
  end

end
