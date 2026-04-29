#! /usr/bin/ruby

def missingletter(a)
  c = a.chars.select{|x| x != ' '}.map{|x| x.ord}
  d = []
  c.each_cons(2) do |i|
    if i[0] == 63 || i[1] == 63
      d.push(0)
    else
      d.push(i[1] - i[0])
    end
  end
  d.each_with_index do |delta, n|
    if delta == 0
      ch = 0
      if n < 2
        ch = c[n + 2] - d[n + 2]
      else
        ch = c[n] + d[n - 2]
      end
      return ch.chr
    end
  end
  ""
end

require 'test/unit'

class TestMissingletter < Test::Unit::TestCase

  def test_ex1
    assert_equal('e', missingletter('a c ? g i'))
  end

  def test_ex2
    assert_equal('g', missingletter('a d ? j m'))
  end

  def test_ex3
    assert_equal('i', missingletter('a e ? m q'))
  end

  def test_ex4
    assert_equal('h', missingletter('a c f ? k'))
  end

  def test_ex5
    assert_equal('j', missingletter('b e g ? l'))
  end

end
