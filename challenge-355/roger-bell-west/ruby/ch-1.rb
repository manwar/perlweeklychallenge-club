#! /usr/bin/ruby

def thousandseparator(a)
  out = ""
  s = a.to_s
  offset = 2 - ((s.size + 2) % 3)
  s.chars.each_with_index do |d, i|
    if i > 0 && (i + offset) % 3 == 0
      out += ','
    end
    out += d
  end
  out
end

require 'test/unit'

class TestThousandseparator < Test::Unit::TestCase

  def test_ex1
    assert_equal('123', thousandseparator(123))
  end

  def test_ex2
    assert_equal('1,234', thousandseparator(1234))
  end

  def test_ex3
    assert_equal('1,000,000', thousandseparator(1000000))
  end

  def test_ex4
    assert_equal('1', thousandseparator(1))
  end

  def test_ex5
    assert_equal('12,345', thousandseparator(12345))
  end

end
