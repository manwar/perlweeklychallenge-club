#! /usr/bin/ruby

def cc(s,n)
  plain=('A'..'Z').to_a
  cmap=Hash.new
  asize=plain.length
  0.upto(asize-1) do |p|
    c=(p+asize*2-n) % asize
    cmap[plain[p]]=plain[c]
  end
  out=""
  s.split('').each do |ss|
    if cmap.has_key?(ss) then
      out += cmap[ss]
    else
      out += ss
    end
  end
  return out
end

require 'test/unit'

class TestCc < Test::Unit::TestCase

  def test_ex1
    assert_equal('QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD',cc('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG',3))
  end

  def test_ex2
    assert_equal('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG',cc('QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD',-3))
  end

  def test_ex3
    assert_equal('N DHVPX ZBIRZRAG BS GUR RARZL JVYY WRBCNEQVMR FVK THAOBNGF',cc('A QUICK MOVEMENT OF THE ENEMY WILL JEOPARDIZE SIX GUNBOATS',13))
  end

end
