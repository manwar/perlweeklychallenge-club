#! /usr/bin/ruby

def commoncharacters(a)
  ac = []
  a.each do |w|
    h = Hash.new(0)
    w.split('').each do |c|
      h[c] += 1
    end
    ac.push(h)
  end
  vc = ac[0]
  ac.each do |aa|
    vc.keys.each do |c|
      if aa.has_key?(c) then
        vc[c] = [vc[c], aa[c]].min
      else
        vc.delete(c)
      end
    end
  end
  out = []
  a[0].split("").each do |c|
    if vc.has_key?(c) then
      out.push(c)
      vc[c] -= 1
      if vc[c] == 0 then
        vc.delete(c)
      end
    end
  end
  return out
end

require 'test/unit'

class TestCommoncharacters < Test::Unit::TestCase

  def test_ex1
    assert_equal(['j', 'a'], commoncharacters(['java', 'javascript', 'julia']))
  end

  def test_ex2
    assert_equal(['e', 'l', 'l'], commoncharacters(['bella', 'label', 'roller']))
  end

  def test_ex3
    assert_equal(['c', 'o'], commoncharacters(['cool', 'lock', 'cook']))
  end

end
