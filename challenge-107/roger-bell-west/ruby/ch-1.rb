#! /usr/bin/ruby

def sdn(count)
  r=Array.new
  n=10
  while (r.length < count)
    ns=sprintf('%d',n).chars.collect {|i| Integer(i)}
    d=Array.new(10,0);
    ns.collect{|i| d[i]+=1}
    sd=true
    0.upto(ns.length-1) do |i|
      if d[i] != ns[i] then
        sd=false
        break
      end
    end
    if sd && ns.length<10 then
      ns.length.upto(9) do |i|
        if d[i] != 0 then
          sd=false
          break
        end
      end
    end
    if sd then
      r.push(n)
    end
    n+=10
  end
  return r
end

require 'test/unit'

class TestSdn < Test::Unit::TestCase

  def test_ex1
    assert_equal([1210, 2020, 21200],sdn(3))
  end

end
