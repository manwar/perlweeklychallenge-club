#! /usr/bin/ruby

require 'set'

def isqrt(s)
  if s <= 1
    return s
  end
  x0 = s.div(2);
  x1 = (x0 + s.div(x0)).div(2)
  while x1 < x0
    x0 = x1;
    x1 = (x0 + s.div(x0)).div(2)
  end
  return x0
end

def is_adjacentsquared(param, hc)
  hcs = hc.sort
  if hcs != 1.upto(param).to_a
    print("bad seq #{hcs}\n")
    return false
  end
  0.upto(param - 2) do |i|
    pn = hc[i] + hc[i + 1]
    sn = isqrt(pn)
    if pn != sn * sn
      print("bad value #{i} #{pn}\n")
      return false
    end
  end
  pn = hc[0] + hc[hc.size - 1]
  sn = isqrt(pn)
  if pn != sn * sn
      print("bad value ends #{pn}\n")
      return false
    return false
  end
  true
end

def hamiltoniancycle(a)
  if a < 31
    return []
  end
  perfectsquares = Set.new
  lim = a * 2
  1.upto(a) do |p|
    ps = p * p
    if ps > lim
      break
    end
    perfectsquares.add(ps)
  end
  neighbours = Hash.new
  1.upto(a) do |x|
    perfectsquares.each do |y|
      if y > x
        z = y - x
        if z <= a
          s = Set.new
          if neighbours.has_key?(x)
            s = neighbours[x]
          end
          s.add(z)
          neighbours[x] = s
          s = Set.new
          if neighbours.has_key?(z)
            s = neighbours[z]
          end
          s.add(x)
          neighbours[z] = s
        end
      end
    end
  end
  stack = []
  stack.push([1])
  while stack.size > 0
    lst = stack.pop
    if lst.size == a
      if perfectsquares.include?(lst[0] + lst[lst.size - 1])
        return lst
      end
    else
      neighbours[lst[lst.size - 1]].each do |candidate|
        unless lst.include?(candidate)
          nlst = lst.clone
          nlst.push(candidate)
          stack.push(nlst)
        end
      end
    end
  end
  []
end

require 'test/unit'

class TestHamiltoniancycle < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, is_adjacentsquared(32, hamiltoniancycle(32)))
  end

  def test_ex2
    assert_equal([], hamiltoniancycle(15))
  end

  def test_ex3
    assert_equal(true, is_adjacentsquared(34, hamiltoniancycle(34)))
  end

end
