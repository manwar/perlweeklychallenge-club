#! /usr/bin/ruby

def ts(*a)
  n=a.find_all { |v| v<2 }
  a.combination(3) do |b|
    s=b.sum
    if (s > 1 and s < 2)
      return 1
    end
  end
  return 0
end

require 'test/unit'

class TestTs < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,ts(1.2, 0.4, 0.1, 2.5))
  end

  def test_ex2
    assert_equal(0,ts(0.2, 1.5, 0.9, 1.1))
  end

  def test_ex3
    assert_equal(1,ts(0.5, 1.1, 0.3, 0.7))
  end

end
