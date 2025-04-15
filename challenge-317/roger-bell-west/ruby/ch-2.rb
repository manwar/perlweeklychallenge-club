#! /usr/bin/ruby

def friendlystrings(a, b)
  aa = a.chars()
  bb = b.chars()
  0.upto(aa.length - 2) do |i|
    (i + 1).upto(aa.length - 1) do |j|
      cc = aa.clone
      cc[i] = aa[j]
      cc[j] = aa[i]
      if cc == bb
        return true
      end
    end
  end
  false
end

require 'test/unit'

class TestFriendlystrings < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, friendlystrings('desc', 'dsec'))
  end

  def test_ex2
    assert_equal(true, friendlystrings('fuck', 'fcuk'))
  end

  def test_ex3
    assert_equal(false, friendlystrings('poo', 'eop'))
  end

  def test_ex4
    assert_equal(true, friendlystrings('stripe', 'sprite'))
  end

end
