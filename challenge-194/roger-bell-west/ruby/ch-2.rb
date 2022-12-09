#! /usr/bin/ruby

require 'test/unit'

def frequencyequalizer(s)
  f = Hash.new
  s.chars.each do |c|
    if !f.has_key?(c) then
      f[c] = 0
    end
    f[c] += 1
  end
  v = f.values.sort
  if v[0] == v[-2] &&
     v[0] + 1 == v[-1] then
    return true
  end
  return false
end

class TestFrequencyEqualizer < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, frequencyequalizer("abbc"))
  end

  def test_ex2
    assert_equal(true, frequencyequalizer("xyzyyxz"))
  end

  def test_ex3
    assert_equal(false, frequencyequalizer("xzxz"))
  end
end
