#! /usr/bin/ruby

def goatlatin(a)
  out = []
  a.split(" ").each_with_index do |word, ix|
    c = word.split("")
    if c[0] !~ /[aeiou]/i
      co = c.shift;
      c.push(co)
    end
    nw = c.join("")
    nw += "ma"
    0.upto(ix) do
      nw += "a"
    end
    out.push(nw)
  end
  return out.join(" ")
end

require 'test/unit'

class TestGoatlatin < Test::Unit::TestCase

  def test_ex1
    assert_equal('Imaa ovelmaaa erlPmaaaa', goatlatin('I love Perl'))
  end

  def test_ex2
    assert_equal('erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa', goatlatin('Perl and Raku are friends'))
  end

  def test_ex3
    assert_equal('heTmaa eeklyWmaaa hallengeCmaaaa', goatlatin('The Weekly Challenge'))
  end

end
