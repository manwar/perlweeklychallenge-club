#! /usr/bin/ruby

def magicexpression(number, target)
  n = number.chars
  l = n.size - 1
  counter = Array.new(l, 0)
  out = Array.new
  loop do
    i = 0
    counter[i] += 1
    brk = false
    while counter[i] == 4
      counter[i] = 0
      i += 1
      if i < l
        counter[i] += 1
      else
        brk = true
        break
      end
    end
    if brk
      break
    end
    ex = ""
    0.upto(l - 1) do |i|
      ex += n[i]
      ex += ["", "+", "-", "*"][counter[i]]
    end
    ex += n[l]
    if ex =~ /(^|\D)0\d/
      next
    end
    if eval(ex) == target
      out.push(ex)
    end
  end
  out.sort!
  out
end

require 'test/unit'

class TestMagicexpression < Test::Unit::TestCase

  def test_ex1
    assert_equal(['1*2*3', '1+2+3'], magicexpression('123', 6))
  end

  def test_ex2
    assert_equal(['1*0+5', '10-5'], magicexpression('105', 5))
  end

  def test_ex3
    assert_equal(['2*3+2', '2+3*2'], magicexpression('232', 8))
  end

  def test_ex4
    assert_equal(['1*2*3+4', '1+2+3+4'], magicexpression('1234', 10))
  end

  def test_ex5
    assert_equal(['1+0*0+1', '1+0+0+1', '1+0-0+1', '1-0*0+1', '1-0+0+1', '1-0-0+1'], magicexpression('1001', 2))
  end

end
