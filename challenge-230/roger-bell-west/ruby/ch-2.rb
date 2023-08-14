#! /usr/bin/ruby

def prefixwords(s, p)
  return s.count {|i| i.index(p) == 0}
end

require 'test/unit'

class TestPrefixwords < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, prefixwords(['pay', 'attention', 'practice', 'attend'], 'at'))
  end

  def test_ex2
    assert_equal(3, prefixwords(['janet', 'julia', 'java', 'javascript'], 'ja'))
  end

end
