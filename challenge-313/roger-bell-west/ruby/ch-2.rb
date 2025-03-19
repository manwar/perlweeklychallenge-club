#! /usr/bin/ruby

def reverseletters(a)
  vout = Array.new(a.size, ' ')
  letterslots = Array.new
  letters = Array.new
  a.chars().each_with_index do |c, i|
    if (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')
      letterslots.push(i)
      letters.push(c)
    else
      vout[i] = c
    end
  end
  letterslots.each do |i|
    vout[i] = letters.pop()
  end
  vout.join("")
end

require 'test/unit'

class TestReverseletters < Test::Unit::TestCase

  def test_ex1
    assert_equal('l-re?p', reverseletters('p-er?l'))
  end

  def test_ex2
    assert_equal('yLk-e!e-w', reverseletters('wee-k!L-y'))
  end

  def test_ex3
    assert_equal('_e-!g_nel-la!h_c', reverseletters('_c-!h_all-en!g_e'))
  end

end
