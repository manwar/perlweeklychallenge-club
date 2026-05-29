#! /usr/bin/ruby

def findkbeauty(a, n)
  total = 0
  c = a.to_s.chars
  c.each_cons(n) do |t|
    tn = t.join("").to_i
    if a % tn == 0
      total += 1
    end
  end
  total
end

require 'test/unit'

class TestFindkbeauty < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, findkbeauty(240, 2))
  end

  def test_ex2
    assert_equal(3, findkbeauty(1020, 2))
  end

  def test_ex3
    assert_equal(0, findkbeauty(444, 2))
  end

  def test_ex4
    assert_equal(1, findkbeauty(17, 2))
  end

  def test_ex5
    assert_equal(2, findkbeauty(123, 1))
  end

end
