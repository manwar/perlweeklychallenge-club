#! /usr/bin/ruby

def prefixsuffix(a0)
  tot = 0
  a = a0.sort_by { |x| x.size }
  0.upto(a.size - 2) do |si|
    (si + 1).upto(a.size - 1) do |li|
      le = a[li].index(a[si])
      ri = a[li].rindex(a[si])
      if le == 0 && ri == a[li].size - a[si].size
        tot += 1
      end
    end
  end
  tot
end

require 'test/unit'

class TestPrefixsuffix < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, prefixsuffix(['a', 'aba', 'ababa', 'aa']))
  end

  def test_ex2
    assert_equal(2, prefixsuffix(['pa', 'papa', 'ma', 'mama']))
  end

  def test_ex3
    assert_equal(0, prefixsuffix(['abao', 'abab']))
  end

  def test_ex4
    assert_equal(1, prefixsuffix(['abab', 'abab']))
  end

  def test_ex5
    assert_equal(3, prefixsuffix(['ab', 'abab', 'ababab']))
  end

end
