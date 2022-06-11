#! /usr/bin/ruby

require 'test/unit'

def pythagoreanmeans(s)
  return {
    "AM" => arithmeticmean(s).round(1).to_f,
    "GM" => geometricmean(s).round(1).to_f,
    "HM" => harmonicmean(s).round(1).to_f
  }
end

def arithmeticmean(s)
  return (s.inject(:+)) /s.length
end

def geometricmean(s)
  return s.inject(:*) ** (1/s.length.to_f)
end

def harmonicmean(s)
  return s.length/(s.collect {|x| 1/x.to_f}.inject(:+))
end

class TestPythagoreanmeans < Test::Unit::TestCase

  def test_ex1
    assert_equal({"AM" => 5.0, "GM" => 3.9, "HM" => 2.8},
                 pythagoreanmeans([1,3,5,7,9]))
  end

  def test_ex2
    assert_equal({"AM" => 6.0, "GM" => 5.2, "HM" => 4.4},
                 pythagoreanmeans([2,4,6,8,10]))
  end

  def test_ex3
    assert_equal({"AM" => 3.0, "GM" => 2.6, "HM" => 2.2},
                 pythagoreanmeans([1,2,3,4,5]))
  end

end
