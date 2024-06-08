#! /usr/bin/ruby

def defrangip(a)
  return a.gsub(".", "[.]")
end

require 'test/unit'

class TestDefrangip < Test::Unit::TestCase

  def test_ex1
    assert_equal('1[.]1[.]1[.]1', defrangip('1.1.1.1'))
  end

  def test_ex2
    assert_equal('255[.]101[.]1[.]0', defrangip('255.101.1.0'))
  end

end
