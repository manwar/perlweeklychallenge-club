#! /usr/bin/crystal

def a2n(a)
  t = 0
  a.each do |d|
    t *= 10
    t += d
  end
  t
end

def kaprekarconstant(a)
  ct = 0
  b = a
  while b != 6174
    if b == 0
      return -1
    end
    digits = Array(Int32).new
    0.upto(3) do
      b, d = b.divmod(10)
      digits.push(d)
    end
    digits = digits.sort()
    stigid = digits.reverse()
    b = a2n(stigid) - a2n(digits)
    ct += 1
  end
  ct
end

require "spec"
describe "kaprekarconstant" do
  it "test_ex1" do
    kaprekarconstant(3524).should eq 3
  end
  it "test_ex2" do
    kaprekarconstant(6174).should eq 0
  end
  it "test_ex3" do
    kaprekarconstant(9998).should eq 5
  end
  it "test_ex4" do
    kaprekarconstant(1001).should eq 4
  end
  it "test_ex5" do
    kaprekarconstant(9000).should eq 4
  end
  it "test_ex6" do
    kaprekarconstant(1111).should eq -1
  end
end
