#! /usr/bin/ruby

require 'set'

def getlistset(a)
  la = a.split(' ')
  ca = Hash.new(0)
  la.each do |c|
    ca[c] += 1
  end
  la = la.find_all{|k| ca[k] == 1}
  return [la, Set.new(ca.keys)]
end

def uncommonwords(a, b)
  (la, sa) = getlistset(a)
  (lb, sb) = getlistset(b)
  out = []
  [[la, sb], [lb, sa]].each do |wl, t|
    wl.each do |w|
      if !t.include?(w) then
        out.push(w)
      end
    end
  end
  return out
end

require 'test/unit'

class TestUncommonwords < Test::Unit::TestCase

  def test_ex1
    assert_equal(['sweet', 'sour'], uncommonwords('Mango is sweet', 'Mango is sour'))
  end

  def test_ex2
    assert_equal(['Orange'], uncommonwords('Mango Mango', 'Orange'))
  end

  def test_ex3
    assert_equal([], uncommonwords('Mango is Mango', 'Orange is Orange'))
  end

end
