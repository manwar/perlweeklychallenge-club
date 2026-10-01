#! /usr/bin/crystal

def genprimes(mx)
  primesh=Set.new([2,3])
  (6..mx+1).step(6) do |i|
    (i-1..i+1).step(2) do |j|
      if j <= mx
        primesh.add(j)
      end
    end
  end
  q=[2,3,5,7]
  p=q.shift
  mr=isqrt(mx)
  while p <= mr
    if primesh.includes?(p)
      (p*p..mx).step(p) do |i|
        primesh.delete(i)
      end
    end
    if q.size < 2
      q.push(q[-1]+4)
      q.push(q[-1]+2)
    end
    p=q.shift
  end
  return primesh.each.to_a.sort
end

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

def primestep(a)
  g = a.chars.map{|c| c.ord}.sum
  pm = genprimes(g * 2)
  lo = pm.select{|x| x <= g}[-1]
  hi = pm.select{|x| x > g}[0]
  [g - lo, hi - g].min
end

require "spec"
describe "primestep" do
  it "test_ex1" do
    primestep("hello").should eq 9
  end
  it "test_ex2" do
    primestep("football").should eq 2
  end
  it "test_ex3" do
    primestep("a").should eq 0
  end
  it "test_ex4" do
    primestep("challenge").should eq 2
  end
  it "test_ex5" do
    primestep("perl").should eq 2
  end
end
