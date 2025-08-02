#! /usr/bin/ruby

def stepbystep(a)
  mv = 0
  tot = 0
  a.each do |s|
    tot += s
    if mv > tot
      mv = tot
    end
  end
  1 - mv
end

require 'test/unit'

class TestStepbystep < Test::Unit::TestCase

  def test_ex1
    assert_equal(5, stepbystep([-3, 2, -3, 4, 2]))
  end

  def test_ex2
    assert_equal(1, stepbystep([1, 2]))
  end

  def test_ex3
    assert_equal(5, stepbystep([1, -2, -3]))
  end

end
