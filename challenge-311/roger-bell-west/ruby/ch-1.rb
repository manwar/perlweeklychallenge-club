#! /usr/bin/ruby

def upperlower(a)
  out = ""
  a.chars.each do |c|
    out += (c.ord ^ 32).chr
  end
  out
end

require 'test/unit'

class TestUpperlower < Test::Unit::TestCase

  def test_ex1
    assert_equal('Perl', upperlower('pERL'))
  end

  def test_ex2
    assert_equal('RAKu', upperlower('rakU'))
  end

  def test_ex3
    assert_equal('pYtHoN', upperlower('PyThOn'))
  end

end
