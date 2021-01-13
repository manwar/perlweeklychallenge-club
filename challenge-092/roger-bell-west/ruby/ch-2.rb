#! /usr/bin/ruby

def ii(iv,nv)
  q=iv
  q.push(nv)
  q.sort! {|a,b| a[0] <=> b[0]}
  out=Array.new
  q.each do |il|
    if out.length==0 ||
       out[-1][1] < il[0] then
      out.push(il)
    else
      out[-1][1]=[out[-1][1],il[1]].max
    end
  end
  return out
end

require 'test/unit'

class TestIi < Test::Unit::TestCase

  def test_ex1
    assert_equal([[1,6],[8,10]],ii([[1,4],[8,10]],[2,6]))
  end

  def test_ex2
    assert_equal([[1,2],[3,10]],ii([[1,2],[3,7],[8,10]],[5,8]))
  end

  def test_ex3
    assert_equal([[1,5],[7,9],[10,11]],ii([[1,5],[7,9]],[10,11]))
  end

  def test_ex4
    assert_equal([[1,5],[7,9],[10,11]],ii([[7,9],[10,11]],[1,5]))
  end

  def test_ex5
    assert_equal([[1,5],[7,9],[10,11]],ii([[1,5],[10,11]],[7,9]))
  end

end
