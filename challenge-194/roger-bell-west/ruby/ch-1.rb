#! /usr/bin/ruby

require 'test/unit'

def digitalclock(hhmm)
  i = hhmm.index("?")
  if i == 0 then
    if hhmm[1] <= "3" then
      return 2
    end
    return 1
  elsif i == 1 then
    if hhmm[0] < "2" then
      return 9
    end
    return 3
  elsif i == 3 then
    return 5
  elsif i == 4 then
    return 9
  end
  return 0
end

class TestDigitalclock < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, digitalclock("?5:00"))
  end

  def test_ex2
    assert_equal(2, digitalclock("?3:00"))
  end

  def test_ex3
    assert_equal(9, digitalclock("1?:00"))
  end

  def test_ex4
    assert_equal(3, digitalclock("2?:00"))
  end

  def test_ex5
    assert_equal(5, digitalclock("12:?5"))
  end

  def test_ex6
    assert_equal(9, digitalclock("12:5?"))
  end

end
