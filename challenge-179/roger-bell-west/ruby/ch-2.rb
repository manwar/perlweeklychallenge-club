#! /usr/bin/ruby
# coding: utf-8

require 'test/unit'

def sparkline(nn)
  bar = []
  9601.upto(9608) do |bc|
    bar.push(bc.chr(Encoding::UTF_8))
  end
  mn = nn.min
  mx = nn.max
  inscale = mx - mn
  outscale = bar.length
  return nn.collect {|n| bar[[
                               (((n-mn) * outscale).to_f / inscale.to_f).to_i,
                               outscale - 1
                             ].min]}.join("")
end

class TestSparkline < Test::Unit::TestCase

  def test_ex1
    assert_equal("▁█", sparkline([0, 100]))
  end

  def test_ex2
    assert_equal("▁▂▃▄▅▆▇█", sparkline([1, 2, 3, 4, 5, 6, 7, 8]))
  end

end
