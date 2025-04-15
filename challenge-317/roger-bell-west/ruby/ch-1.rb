#! /usr/bin/ruby

def acronyms(a, b)
  os = ""
  a.each do |c|
    os += c[0]
  end
  os == b
end

require 'test/unit'

class TestAcronyms < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, acronyms(['Perl', 'Weekly', 'Challenge'], 'PWC'))
  end

  def test_ex2
    assert_equal(true, acronyms(['Bob', 'Charlie', 'Joe'], 'BCJ'))
  end

  def test_ex3
    assert_equal(false, acronyms(['Morning', 'Good'], 'MM'))
  end

end
