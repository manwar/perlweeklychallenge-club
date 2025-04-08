#! /usr/bin/ruby

def subsequence(a, b)
  l = a
  s = b
  if a.size < b.size
    l = b
    s = a
  end
  st = s.chars()
  si = 0
  l.each_char do |c|
    if c == st[si]
      si += 1
      if si >= st.size
        return true
      end
    end
  end
  false
end

require 'test/unit'

class TestSubsequence < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, subsequence('uvw', 'bcudvew'))
  end

  def test_ex2
    assert_equal(false, subsequence('aec', 'abcde'))
  end

  def test_ex3
    assert_equal(true, subsequence('sip', 'javascript'))
  end

end
