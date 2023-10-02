#! /usr/bin/ruby

require 'date'

def friday13th(y)
  f = 0
  1.upto(12) do |m|
    if Date.new(y, m, 13).wday == 5 then
      f += 1
    end
  end
  return f
end

require 'test/unit'

class TestFriday13th < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, friday13th(2023))
  end

end
