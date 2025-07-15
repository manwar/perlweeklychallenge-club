#! /usr/bin/ruby

def titlecapital(a)
  out = Array.new
  a.split(" ").each do |w|
    p = w.downcase
    if p.size > 2
      c = p.chars
      c[0] = c[0].upcase
      p = c.join("")
    end
    out.push(p)
  end
  out.join(" ")
end

require 'test/unit'

class TestTitlecapital < Test::Unit::TestCase

  def test_ex1
    assert_equal('Perl is Great', titlecapital('PERL IS gREAT'))
  end

  def test_ex2
    assert_equal('The Weekly Challenge', titlecapital('THE weekly challenge'))
  end

  def test_ex3
    assert_equal('You Are a Star', titlecapital('YoU ARE A stAR'))
  end

end
