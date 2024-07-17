#! /usr/bin/ruby

def sortstring(a)
  words = a.split(" ")
  out = words.clone
  words.each do |w|
    if md = /^(.*?)([0-9]+)$/.match(w)
      ix = md[2].to_i - 1
      out[ix] = md[1]
    end
  end
  out.join(" ")
end

require 'test/unit'

class TestSortstring < Test::Unit::TestCase

  def test_ex1
    assert_equal('Perl and Raku are cousins', sortstring('and2 Raku3 cousins5 Perl1 are4'))
  end

  def test_ex2
    assert_equal('Python is the most popular guest language', sortstring('guest6 Python1 most4 the3 popular5 is2 language7'))
  end

  def test_ex3
    assert_equal('The Weekly Challenge', sortstring('Challenge3 The1 Weekly2'))
  end

end
