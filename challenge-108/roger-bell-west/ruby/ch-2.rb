#! /usr/bin/ruby

def bell(count)
  a=[[1]]
  1.upto(count-1) do |row|
    b=[a[-1][-1]]
    1.upto(row) do |col|
      b.push(b[col-1]+a[-1][col-1])
    end
    a.push(b)
  end
  return a.map{|i| i[0]}
end

require 'test/unit'

class TestBell < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147],bell(10))
  end

end
