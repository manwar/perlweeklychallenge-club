#! /usr/bin/ruby

def onesandzeroes(a, zeroes, ones)
  ax = Array.new
  a.each do |ns|
    o = 0
    n = 0
    ns.chars.each do |c|
      case c
      when '0'
        o += 1
      when '1'
        n += 1
      end
    end
    ax.push([o, n]);
  end
  mx = 0
  1.upto((1 << ax.size) - 1) do |mask|
    o = 0
    n = 0
    ct = 0
    ax.each_with_index do |x, i|
      if (mask & (1 << i)) > 0
        o += x[0]
        n += x[1]
        ct += 1
        if o > zeroes || n > ones
          break
        end
      end
    end
    if o <= zeroes && n <= ones
      mx = [mx, ct].max
    end
  end
  mx
end

require 'test/unit'

class TestOnesandzeroes < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, onesandzeroes(['10', '0001', '111001', '1', '0'], 5, 3))
  end

  def test_ex2
    assert_equal(2, onesandzeroes(['10', '1', '0'], 1, 1))
  end

end
