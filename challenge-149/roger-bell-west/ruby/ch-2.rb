#! /usr/bin/ruby

require 'test/unit'

def ls(base)
  max=0
  base.downto(0) do |i|
    max *= base
    max += i
  end
  digits="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  t=Integer.sqrt(max)
  while true do
    s=t*t
    v=true
    c=Array.new(base) { 0 }
    dg=""
    while s > 0 do
      d = s % base
      c[d] += 1
      if c[d] > 1 then
        v=false
        break
      end
      s = (s/base).to_i
      dg = digits[d] + dg
    end
    if v then
      return dg
    end
    t -= 1
  end
end

class TestLs < Test::Unit::TestCase

  def test_ex1
    assert_equal("1",ls(2))
  end

  def test_ex2
    assert_equal("3201",ls(4))
  end

  def test_ex3
    assert_equal("9814072356",ls(10))
  end

  def test_ex4
    assert_equal("B8750A649321",ls(12))
  end

end
