#! /usr/bin/ruby

require 'test/unit'

class Rect
  attr_reader :xy1, :xy2
  def initialize(_xy1,_xy2)
    @xy1=[[_xy1[0],_xy2[0]].min,[_xy1[1],_xy2[1]].min]
    @xy2=[[_xy1[0],_xy2[0]].max,[_xy1[1],_xy2[1]].max]
  end

  def area
    area=1
    0.upto(1) do |axis|
      area *= @xy2[axis]-@xy1[axis]
    end
    return area
  end

  def overlap(other)
    area=1
    0.upto(1) do |axis|
      area *= [0,
        [@xy2[axis],other.xy2[axis]].min-
        [@xy1[axis],other.xy1[axis]].max
              ].max
    end
    return area
  end

  def fullarea(other)
    return area()+other.area()-overlap(other)
  end
end

class TestRect < Test::Unit::TestCase

  def test_ex1
    assert_equal(22,Rect.new([-1,0],[2,2]).fullarea(Rect.new([0,-1],[4,4])))
  end

  def test_ex2
    assert_equal(25,Rect.new([-3,-1],[1,3]).fullarea(Rect.new([-1,-3],[2,2])))
  end

end
