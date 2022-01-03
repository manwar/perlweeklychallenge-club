#! /usr/bin/ruby

require 'set'

class Fraction
  attr_accessor :n, :d
  def initialize
    @n=1
    @d=1
  end

  def get_parent
    p=Fraction.new
    p.n=@n
    p.d=@d
    if p.n < p.d then
      p.d -= p.n
    else
      p.n -= p.d
    end
    return p
  end

  def stringify
    return "#{@n}/#{@d}"
  end

  def set_from_string(s)
    q=s.split('/')
    @n=q[0].to_i
    @d=q[1].to_i
    return self
  end
end

def p_gp(s)
  f=Fraction.new.set_from_string(s)
  out=[]
  1.upto(2) do
    f=f.get_parent
    out.push(f.stringify)
  end
  return out
end

require 'test/unit'

class TestP_Gp < Test::Unit::TestCase

  def test_ex1
    assert_equal(["3/2","1/2"],p_gp("3/5"))
  end

  def test_ex2
    assert_equal(["1/3","1/2"],p_gp("4/3"))
  end

end
