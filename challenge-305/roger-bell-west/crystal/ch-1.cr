#! /usr/bin/crystal

def isqrt(s)
  if s <= 1
    return s
  end
  x0 = s / 2;
  x1 = (x0 + s / x0) / 2;
  while x1 < x0
    x0 = x1
    x1 = (x0 + s / x0) / 2
  end    
  x0
end

def is_prime(n)
  if n == 1
    return false
  end
  if n>2 && n%2==0 
    return false
  end
  if n>3 && n%3==0
    return false
  end
  lim = isqrt(n)
  k6 = 0;
  while true
    k6 += 6
    (k6 - 1).step(to: k6 + 1, by: 2) do |t|
      if t <= lim
        if n % t == 0
          return false
        end
      else
        return true
      end
    end
  end
end

def binaryprefix(a)
  out = Array(Bool).new
  n = 0
  a.each do |x|
    n *= 2
    if x == 1
      n += 1
    end
    out.push(is_prime(n))
  end
  out
end

require "spec"
describe "binaryprefix" do
  it "test_ex1" do
    binaryprefix([1, 0, 1]).should eq [false, true, true]
  end
  it "test_ex2" do
    binaryprefix([1, 1, 0]).should eq [false, true, false]
  end
  it "test_ex3" do
    binaryprefix([1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1]).should eq [false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true]
  end
end
