#! /usr/bin/ruby

def sp(*t)
  s=0
  path=[[0]]
  while (a=path.shift) do
    c=(a[-1]+1)*2-1
    tn=true
    c.upto(c+1) do |ac|
      if ac <= t.length && !t[ac].nil? then
        path.push([a,ac].flatten)
        tn=false
      end
    end
    if tn
      s += a.map{|i| t[i]}.sum()
    end
  end
  return s
end

require 'test/unit'

class TestSp < Test::Unit::TestCase

  def test_ex1
    assert_equal(13,sp(1,2,nil,3,4))
  end

  def test_ex2
    assert_equal(26,sp(1,2,3,4,nil,5,6))
  end

end
