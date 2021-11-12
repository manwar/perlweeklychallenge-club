#! /usr/bin/ruby

def splnum(n)
  k=Integer.sqrt(n)
  if k*k!=n then
    return 0
  end
  d=n.to_s.split("")
  dl=d.length-1
  1.upto((1<<dl)-1) do |s|
    sa=[0]
    0.upto(dl-1) do |i|
      if s & (1<<i) > 0 then
        sa.push(i+1)
      end
    end
    sa.push(dl+1)
    c=0
    0.upto(sa.length()-2) do |j|
      c+=d.slice(sa[j],sa[j+1]-sa[j]).join("").to_i
    end
    if c==k then
      return 1
    end
  end
  return 0
end

require 'test/unit'

class TestSplnum < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,splnum(81))
  end

  def test_ex2
    assert_equal(1,splnum(9801))
  end

  def test_ex3
    assert_equal(0,splnum(36))
  end

end
