#! /usr/bin/ruby

require 'test/unit'

def fim(n0)
  words=["zero","one","two","three","four",
         "five","six","seven","eight","nine"]
  n=n0
  p=[]
  while true do
    s = words[n] + " is "
    if n==4 then
      s += "magic."
      p.push(s)
      break
    else
      n = words[n].length
      s += words[n]
      p.push(s)
    end
  end
  return p.join(", ").capitalize
end

class TestFim < Test::Unit::TestCase

  def test_ex1
    assert_equal("Five is four, four is magic.",
                 fim(5))
  end

  def test_ex2
    assert_equal("Seven is five, five is four, four is magic.",
                 fim(7))
  end

  def test_ex3
    assert_equal("Six is three, three is five, five is four, four is magic.",
                 fim(6))
  end

  def test_ex4
    assert_equal("Four is magic.",
                 fim(4))
  end

end
