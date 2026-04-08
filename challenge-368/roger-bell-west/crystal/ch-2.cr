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

def primefactor(n)
  f = Hash(Int32, Int32).new
  m = n
  genprimes(1 + isqrt(n)).each do |p|
    while m % p == 0
      m //= p
      f.put_if_absent(p, 0)
      f[p] += 1
    end
    if m == 1
      break
    end
  end
  if m > 1
      f.put_if_absent(m, 0)
    f[m] += 1
  end
  f
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

def omega(a, mode)
  pf = primefactor(a)
  if mode == 0
    return pf.size
  else
    return pf.map {|x| x[1]}.sum
  end
end

require "spec"
describe "omega" do
  it "test_ex1" do
    omega(100061, 0).should eq 3
  end
  it "test_ex2" do
    omega(971088, 0).should eq 3
  end
  it "test_ex3" do
    omega(63640, 1).should eq 6
  end
  it "test_ex4" do
    omega(988841, 1).should eq 2
  end
  it "test_ex5" do
    omega(211529, 0).should eq 2
  end
end
