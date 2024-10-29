#! /usr/bin/crystal

def dvalue(a)
  if a[0] < a[1]
    a[0] * 64 + a[1]
  else 
    a[0] + a[1] * 64
  end
end

def counterify(a)
  cc = Hash(Int32, Int32).new(default_value: 0)
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def similardominoes(a)
  c = counterify(a.map { |x| dvalue(x) })
  t = 0
  c.values.each do |v|
    if v > 1
      t += v
    end
  end
  t
end

require "spec"
describe "similardominoes" do
  it "test_ex1" do
    similardominoes([[1, 3], [3, 1], [2, 4], [6, 8]]).should eq 2
  end
  it "test_ex2" do
    similardominoes([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]]).should eq 3
  end
end
