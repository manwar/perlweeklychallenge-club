#! /usr/bin/crystal

def isqrt(s)
  if s <= 1
    return s
  end
  x0 = s // 2;
  x1 = (x0 + s // x0) // 2
  while x1 < x0
    x0 = x1;
    x1 = (x0 + s // x0) // 2
  end
  return x0
end

def is_adjacentsquared(param, hc)
  hcs = hc.sort
  if hcs != 1.upto(param).to_a
    print("bad seq\n")
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
    return Array(Int32).new
  end
  perfectsquares = Set(Int32).new
  lim = a * 2
  1.upto(a) do |p|
    ps = p * p
    if ps > lim
      break
    end
    perfectsquares.add(ps)
  end
  neighbours = Hash(Int32, Set(Int32)).new
  1.upto(a) do |x|
    perfectsquares.each do |y|
      if y > x
        z = y - x
        if z <= a
          s = Set(Int32).new
          if neighbours.has_key?(x)
            s = neighbours[x]
          end
          s.add(z)
          neighbours[x] = s
          s = Set(Int32).new
          if neighbours.has_key?(z)
            s = neighbours[z]
          end
          s.add(x)
          neighbours[z] = s
        end
      end
    end
  end
  stack = Array(Array(Int32)).new
  stack.push([1])
  while stack.size > 0
    lst = stack.pop
    if lst.size == a
      if perfectsquares.includes?(lst[0] + lst[lst.size - 1])
        return lst
      end
    else
      neighbours[lst[lst.size - 1]].each do |candidate|
        unless lst.includes?(candidate)
          nlst = lst.clone
          nlst.push(candidate)
          stack.push(nlst)
        end
      end
    end
  end
  Array(Int32).new
end

require "spec"
describe "hamiltoniancycle" do
  it "test_ex1" do
    is_adjacentsquared(32, hamiltoniancycle(32)).should eq true
  end
  it "test_ex2" do
    hamiltoniancycle(15).should eq Array(Int32).new
  end
  it "test_ex3" do
    is_adjacentsquared(34, hamiltoniancycle(34)).should eq true
  end
end
