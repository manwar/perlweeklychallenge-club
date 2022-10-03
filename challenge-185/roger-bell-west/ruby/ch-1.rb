#! /usr/bin/ruby

require 'test/unit'

def recomposemac(inp)
  out = ""
  count = 0
  inp.chars do |c|
    if (c >= '0' && c <= '9') || (c >= 'a' && c <= 'z') then
      if count == 2 then
        out += ":"
        count = 0
      end
      count += 1
      out += c
    end
  end
  return out
end

class TestRecomposemac < Test::Unit::TestCase

  def test_ex1
    assert_equal("1a:c2:34:f0:b1:c2",
                 recomposemac("1ac2.34f0.b1c2"))
  end

  def test_ex2
    assert_equal("ab:c1:20:f1:34:5a",
                 recomposemac("abc1.20f1.345a"))
  end

end
