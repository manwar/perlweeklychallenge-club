#! /usr/bin/ruby

def rw(n)
  return n.split(' ').reverse.join(' ')
end

require 'test/unit'

class TestRw < Test::Unit::TestCase

  def test_ex1
    assert_equal('Challenge Weekly The',rw('The Weekly Challenge'))
  end

  def test_ex2
    assert_equal('family same the of part are Raku and Perl',rw('    Perl and   Raku are  part of the same family  '))
  end

end
