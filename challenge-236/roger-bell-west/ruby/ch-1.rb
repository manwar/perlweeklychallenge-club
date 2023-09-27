#! /usr/bin/ruby

class Reserve
  def initialize(vv)
    @values = vv.sort.reverse
    @counts = Array.new([0] * vv.length)
    @vm = Hash.new
    @values.each_with_index do |v, n|
      @vm[v] = n
    end
  end

  def makechange(price, tendered)
    val = 0
    tendered.each do |note|
      if !@vm.has_key?(note) then
        return false
      end
      @counts[@vm[note]] += 1
      val += note
    end
    if val < price then
      return false
    end
    val -= price
    0.upto(@values.length - 1) do |bid|
      while val >= @values[bid] && @counts[bid] > 0 do
        val -= @values[bid]
        @counts[bid] -= 1
      end
    end
    return (val == 0)
  end
end

def exactchange(a)
  reserve = Reserve.new([5, 10, 20])
  a.each do |tendered|
    if !reserve.makechange(5, [tendered]) then
      return false
    end
  end
  return true
end

require 'test/unit'

class TestExactchange < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, exactchange([5, 5, 5, 10, 20]))
  end

  def test_ex2
    assert_equal(false, exactchange([5, 5, 10, 10, 20]))
  end

  def test_ex3
    assert_equal(true, exactchange([5, 5, 5, 20]))
  end

end
