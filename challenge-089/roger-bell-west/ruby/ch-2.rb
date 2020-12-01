#! /usr/bin/ruby

def ms(order,start,inc)
  m=Array.new
  1.upto(order) do
    m.push([0] * order)
  end
  x=((order/2)+1).floor
  y=(order/2).floor
  n=start
  while (true) do
    m[x][y]=n
    n+=inc
    xa=(x+1) % order
    ya=(y+1) % order
    if (m[xa][ya]>0)
      xa=(x+2) % order
      ya=y
      if (m[xa][ya]>0)
        break
      end
    end
    x=xa
    y=ya
  end
  return m
end

require 'test/unit'

class TestMs < Test::Unit::TestCase

  def setup
    @ms=ms(3,1,1)
  end

  def test_row1
    assert_equal(15,@ms[0].reduce(:+))
  end

  def test_row2
    assert_equal(15,@ms[1].reduce(:+))
  end

  def test_row3
    assert_equal(15,@ms[2].reduce(:+))
  end

  def test_col1
    assert_equal(15,@ms.each.map {|x| x[0]}.reduce(:+))
  end

  def test_col2
    assert_equal(15,@ms.each.map {|x| x[1]}.reduce(:+))
  end

  def test_col3
    assert_equal(15,@ms.each.map {|x| x[2]}.reduce(:+))
  end

  def test_dia1
    assert_equal(15,0.upto(2).each.map {|x| @ms[x][x]}.reduce(:+))
  end

  def test_dia2
    assert_equal(15,0.upto(2).each.map {|x| @ms[x][2-x]}.reduce(:+))
  end

end

