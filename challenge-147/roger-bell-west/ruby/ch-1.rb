#! /usr/bin/ruby

require 'set'

def genprimes(mx)
  primesh=Set.new([2,3])
  (6..mx+1).step(6) do |i|
    (i-1..i+1).step(2) do |j|
      if j <= mx then
        primesh.add(j)
      end
    end
  end
  q=[2,3,5,7]
  p=q.shift
  mr=Integer.sqrt(mx)
  while p <= mr do
    if primesh.include?(p)
      (p*p..mx).step(p) do |i|
        primesh.delete?(i)
      end
    end
    if q.length<2 then
      q.push(q[-1]+4)
      q.push(q[-1]+2)
    end
    p=q.shift
  end
  return primesh.each.sort
end

def ltruncprimes(count)
  out=[]
  lt=0
  p=genprimes(500).map{|i| i.to_s}
  pp=Set.new(p)
  p.each do |pc|
    l=pc.length()-1
    c=true
    1.upto(l) do |i|
      if !pp.include?(pc[i..l]) then
        c=false
        break
      end
    end
    if c then
      out.push(pc.to_i)
      lt += 1
      if lt >= count then
        break
      end
    end
  end
  return out
end

require 'test/unit'

class TestLtruncprime < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97, 113, 137, 167, 173, 197],ltruncprimes(20))
  end

end
