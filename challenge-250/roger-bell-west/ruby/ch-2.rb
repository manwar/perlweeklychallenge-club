#! /usr/bin/ruby

def alphanumericstringvalue(a)
  l = []
  a.each do |n|
    begin
      l.push(Integer(n))
    rescue ArgumentError
      l.push(n.length)
    end
  end
  return l.max()
end

require 'test/unit'

class TestAlphanumericstringvalue < Test::Unit::TestCase

  def test_ex1
    assert_equal(6, alphanumericstringvalue(['perl', 2, 000, 'python', 'raku']))
  end

  def test_ex2
    assert_equal(1, alphanumericstringvalue([001, 1, 000, 0001]))
  end

end
