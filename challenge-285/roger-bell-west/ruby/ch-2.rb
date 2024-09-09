#! /usr/bin/ruby

def makingchange(a)
  coins = [1, 5, 10, 25, 50]
  max = coins.map { |x| (a / x).to_i }
  pat = []
  0.upto(coins.size - 1) do |i|
    if max[i] > 0
      al = Array.new(max[i] + 1, 0)
      al.fill(0..) { |i| i }
      pat.push(al)
    else
      break
    end
  end
  ct = 0
  pat[0].product(*pat[1..-1]).each do |combo|
    t = 0
    combo.each_with_index do |c, i|
      t += c * coins[i]
      if t > a
        break
      end
    end
    if t == a
      ct += 1
    end
  end
  ct
end

require 'test/unit'

class TestMakingchange < Test::Unit::TestCase

#  def test_ex1
#    assert_equal(2, makingchange(9))
#  end
#
#  def test_ex2
#    assert_equal(6, makingchange(15))
#  end

  def test_ex3
    assert_equal(292, makingchange(100))
  end

end
