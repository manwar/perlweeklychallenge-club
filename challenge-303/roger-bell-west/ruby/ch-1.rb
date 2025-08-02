#! /usr/bin/ruby

require 'set'

def concatenate(a)
  ax = a.map { |x| x.to_s }
  ax.join("").to_i
end

def threedigitseven(a)
  s = Set.new
  1.upto(3) do |d|
    a.permutation(d).each do |px|
      c = concatenate(px)
      if c >= 100 && c <= 999 && c % 2 == 0
        s.add(c)
      end
    end
  end
  s.to_a.sort
end

require 'test/unit'

class TestThreedigitseven < Test::Unit::TestCase

  def test_ex1
    assert_equal([102, 120, 130, 132, 210, 230, 302, 310, 312, 320], threedigitseven([2, 1, 3, 0]))
  end

  def test_ex2
    assert_equal([222, 228, 282, 288, 822, 828, 882], threedigitseven([2, 2, 8, 8, 2]))
  end

end
