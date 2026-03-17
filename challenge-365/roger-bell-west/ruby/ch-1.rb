#! /usr/bin/ruby

def alphabetindexdigitsum(a, k)
  st = ""
  a.chars.each do |c|
    st += (c.ord - 96).to_s
  end
  v = st.to_i
  1.upto(k) do
    j = 0
    while v > 0
      v, x = v.divmod(10)
      j += x
    end
    v = j
  end
  v
end

require 'test/unit'

class TestAlphabetindexdigitsum < Test::Unit::TestCase

  def test_ex1
    assert_equal(6, alphabetindexdigitsum('abc', 1))
  end

  def test_ex2
    assert_equal(9, alphabetindexdigitsum('az', 2))
  end

  def test_ex3
    assert_equal(6, alphabetindexdigitsum('cat', 1))
  end

  def test_ex4
    assert_equal(8, alphabetindexdigitsum('dog', 2))
  end

  def test_ex5
    assert_equal(6, alphabetindexdigitsum('perl', 3))
  end

end
