#! /usr/bin/ruby

require 'set'

def equalstrings(a)
  ca = a.map { |x| x.chars() }.to_set.to_a
  mmlen = ca.map { |x| x.size }.min
  si = 0
  0.upto(mmlen - 1) do |i|
    si = i
    1.upto(ca.size - 1) do |s|
      if ca[0][i] != ca[s][i]
        if i == 0
          return -1
        end
        si -= 1
        break
      end
    end
  end
  a.map { |x| x.size }.sum - a.size * (si + 1)
end

require 'test/unit'

class TestEqualstrings < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, equalstrings(['abc', 'abb', 'ab']))
  end

  def test_ex2
    assert_equal(-1, equalstrings(['ayz', 'cyz', 'xyz']))
  end

  def test_ex3
    assert_equal(3, equalstrings(['yza', 'yzb', 'yzc']))
  end

end
