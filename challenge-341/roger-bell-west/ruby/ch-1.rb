#! /usr/bin/ruby

require 'set'

def brokenkeyboard(a, b)
  bk = Set.new(b.map{|x| x.downcase})
  ct = 0
  a.downcase.split(" ").each do |w|
    nk = Set.new(w.chars)
    if (bk & nk).length == 0
      ct += 1
    end
  end
  ct
end

require 'test/unit'

class TestBrokenkeyboard < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, brokenkeyboard('Hello World', ['d']))
  end

  def test_ex2
    assert_equal(0, brokenkeyboard('apple banana cherry', ['a', 'e']))
  end

  def test_ex3
    assert_equal(3, brokenkeyboard('Coding is fun', []))
  end

  def test_ex4
    assert_equal(2, brokenkeyboard('The Weekly Challenge', ['a', 'b']))
  end

  def test_ex5
    assert_equal(1, brokenkeyboard('Perl and Python', ['p']))
  end

end
