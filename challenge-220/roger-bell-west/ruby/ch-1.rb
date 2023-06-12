#! /usr/bin/ruby

require 'set'

def word2set(word)
  return Set.new(word.downcase.chars.find_all {|i| i >= 'a' && i <= 'z'})
end

def commoncharacters(lst)
  c = word2set(lst[0])
  lst.drop(1).each do |w|
    c = c & word2set(w)
  end
  return c.to_a.sort
end

require 'test/unit'

class TestCommoncharacters < Test::Unit::TestCase

  def test_ex1
    assert_equal(['r'], commoncharacters(['Perl', 'Rust', 'Raku']))
  end

  def test_ex2
    assert_equal(['e', 'l', 'v'], commoncharacters(['love', 'live', 'leave']))
  end

end
