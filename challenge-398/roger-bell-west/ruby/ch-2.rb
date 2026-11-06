#! /usr/bin/ruby

def stringdifference(a)
  da = []
  a.each do |s|
    p = []
    s.chars.each_cons(2) do |d|
      p.push(d[1].ord - d[0].ord)
    end
    da.push(p)
  end
  dx = 0
  1.upto(a.size - 1) do |b|
    if da[0] != da[b]
      if dx > 0
        dx = 0
        break
      else
        dx = b
      end
    end
  end
  a[dx]
end

require 'test/unit'

class TestStringdifference < Test::Unit::TestCase

  def test_ex1
    assert_equal('zy', stringdifference(['ab', 'bc', 'cd', 'zy']))
  end

  def test_ex2
    assert_equal('azy', stringdifference(['cba', 'fed', 'azy']))
  end

  def test_ex3
    assert_equal('pop', stringdifference(['pop', 'ada', 'beb', 'cfc']))
  end

  def test_ex4
    assert_equal('aaba', stringdifference(['aaaa', 'zzzz', 'mmmm', 'aaba']))
  end

  def test_ex5
    assert_equal('azbz', stringdifference(['aceg', 'bdfh', 'cegi', 'azbz']))
  end

end
