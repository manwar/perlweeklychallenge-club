#! /usr/bin/ruby

require 'test/unit'

def recomposemaskcode(list)
  out = []
  list.each do |ins|
    count = 0
    os = ""
    ins.chars do |c|
      if (c >= '0' && c <= '9') || (c >= 'a' && c <= 'z') then
        if count < 4 then
          count += 1
          os += "x"
        else
          os += c
        end
      else
        os += c
      end
    end
    out.push(os)
  end
  return out
end

class TestRecomposemaskcode < Test::Unit::TestCase

  def test_ex1
    assert_equal(["xx-xxe-123", "xxx.xbc.420", "xxxx-0010.xy"],
                 recomposemaskcode(["ab-cde-123", "123.abc.420",
                                    "3abc-0010.xy"]))
  end

  def test_ex2
    assert_equal(["xxxx567.a", "x-xxx4-bc", "x.x.x.x.e.f"],
                 recomposemaskcode(["1234567.a", "a-1234-bc",
                                    "a.b.c.d.e.f"]))
  end

end
