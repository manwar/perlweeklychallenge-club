#! /usr/bin/ruby

require 'set'

def cbs(*strs)
  bss=strs.map {|x| bs(x)}
  r=Set.new
  f=false
  for bsa in bss
    if f
      r=r & Set.new(bsa)
    else
      r=Set.new(bsa)
      f=true
    end
  end
  return r.sort
end

def bs(str)
  sl=str.length
  f=Hash.new
  1.upto(Math.sqrt(sl).floor) do |n|
    p=sl/n
    if p == p.floor
      f[n]=p
      f[p]=n
    end
  end
  out=Array.new
  for l in f.sort_by {|n, p| n}
    q=str[0,l[0]]
    if q * l[1] == str
      out.push(q)
    end
  end
  return out
end
  
require 'test/unit'

class TestCbs < Test::Unit::TestCase

    def test_bs1
      assert_equal(['abcd','abcdabcd'],bs('abcdabcd'))
    end

    def test_bs2
      assert_equal(['a','aaa'],bs('aaa'))
    end

    def test_ex1
      assert_equal(['abcd','abcdabcd'],cbs('abcdabcd','abcdabcdabcdabcd'))
    end

    def test_ex2
      assert_equal(['a',],cbs('aaa','aa'))
    end

end
