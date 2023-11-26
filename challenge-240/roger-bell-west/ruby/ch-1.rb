#! /usr/bin/ruby

def acronym(strs, chk)
  return strs.collect {|x| x[0]}.join("").downcase == chk.downcase
end

require 'test/unit'

class TestAcronym < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, acronym(['Perl', 'Python', 'Pascal'], 'ppp'))
  end

  def test_ex2
    assert_equal(false, acronym(['Perl', 'Raku'], 'rp'))
  end

  def test_ex3
    assert_equal(true, acronym(['Oracle', 'Awk', 'C'], 'oac'))
  end

end
