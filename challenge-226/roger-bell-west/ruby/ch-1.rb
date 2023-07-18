#! /usr/bin/ruby

def shufflestring(st, mp)
  r = " " * st.length
  mp.each do |i|
    r[mp[i]] = st[i]
  end
  return r
end

require 'test/unit'

class TestShufflestring < Test::Unit::TestCase

  def test_ex1
    assert_equal('challenge', shufflestring('lacelengh', [3, 2, 0, 5, 4, 8, 6, 7, 1]))
  end

  def test_ex2
    assert_equal('perlraku', shufflestring('rulepark', [4, 7, 3, 1, 0, 5, 2, 6]))
  end

end
