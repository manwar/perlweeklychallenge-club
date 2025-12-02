#! /usr/bin/ruby

def counterify(a)
  cc = Hash.new
  cc.default = 0
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def countdigits(a)
  counterify(a.to_s.chars)
end

def shufflepairs(low, high, pairs)
  total = 0
  low.upto(high) do |candidate|
    candidatec = countdigits(candidate)
    cnt = 0
    2.upto(9) do |mul|
      test = candidate * mul
      testc = countdigits(test)
      if testc == candidatec
        cnt += 1
        if cnt >= pairs
          break
        end
      end
    end
    if cnt >= pairs
      total += 1
    end
  end
  total
end

require 'test/unit'

class TestShufflepairs < Test::Unit::TestCase

  def test_ex1
    assert_equal(0, shufflepairs(1, 1000, 1))
  end

  def test_ex2
    assert_equal(3, shufflepairs(1500, 2500, 1))
  end

  def test_ex3
    assert_equal(2, shufflepairs(1000000, 1500000, 5))
  end

  def test_ex4
    assert_equal(11, shufflepairs(13427000, 14100000, 2))
  end

  def test_ex5
    assert_equal(7, shufflepairs(1000, 5000, 1))
  end

end
