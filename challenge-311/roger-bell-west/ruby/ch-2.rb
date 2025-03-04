#! /usr/bin/ruby

def groupdigitsum(a, sz)
  s = a
  n = 0
  while true
    t = ""
    s.chars.each_with_index do |c, i|
      n += c.to_i
      if i == s.size - 1 || (i + 1) % sz == 0
        t += n.to_s
        n = 0
      end
    end
    s = t
    if s.size <= sz
      break
    end
  end
  s
end

require 'test/unit'

class TestGroupdigitsum < Test::Unit::TestCase

  def test_ex1
    assert_equal('359', groupdigitsum('111122333', 3))
  end

  def test_ex2
    assert_equal('76', groupdigitsum('1222312', 2))
  end

  def test_ex3
    assert_equal('162', groupdigitsum('100012121001', 4))
  end

end
