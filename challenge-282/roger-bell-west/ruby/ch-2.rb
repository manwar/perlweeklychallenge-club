#! /usr/bin/ruby

require 'test/unit'

class TestChangingkeys < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, changingkeys('pPeERrLl'))
  end

  def test_ex2
    assert_equal(0, changingkeys('rRr'))
  end

  def test_ex3
    assert_equal(1, changingkeys('GoO'))
  end

end

def changingkeys(a)
  oc = 'x'
  out = 0
  a.downcase.chars.each_with_index do |c, i|
    if i == 0
      oc = c
    elsif c != oc
      oc = c
      out += 1
    end
  end
  out
end
