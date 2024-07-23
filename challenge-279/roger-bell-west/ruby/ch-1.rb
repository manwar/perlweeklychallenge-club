#! /usr/bin/ruby

def sortletters(a, n)
  out = a.clone
  a.each_with_index do |l, i|
    out[n[i] - 1] = l
  end
  out.join("")
end

require 'test/unit'

class TestSortletters < Test::Unit::TestCase

  def test_ex1
    assert_equal('PERL', sortletters(['R', 'E', 'P', 'L'], [3, 2, 1, 4]))
  end

  def test_ex2
    assert_equal('RAKU', sortletters(['A', 'U', 'R', 'K'], [2, 4, 1, 3]))
  end

  def test_ex3
    assert_equal('PYTHON', sortletters(['O', 'H', 'Y', 'N', 'P', 'T'], [5, 4, 2, 6, 1, 3]))
  end

end
