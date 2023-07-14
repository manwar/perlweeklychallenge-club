#! /usr/bin/ruby

def maxwords(a)
  return a.collect{|i| i.count(" ")}.max + 1
end

require 'test/unit'

class TestMaxwords < Test::Unit::TestCase

  def test_ex1
    assert_equal(8, maxwords(['Perl and Raku belong to the same family.', 'I love Perl.', 'The Perl and Raku Conference.']))
  end

  def test_ex2
    assert_equal(7, maxwords(['The Weekly Challenge.', 'Python is the most popular guest language.', 'Team PWC has over 300 members.']))
  end

end
