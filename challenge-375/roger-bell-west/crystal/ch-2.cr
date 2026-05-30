#! /usr/bin/crystal

def findkbeauty(a, n)
  total = 0
  c = a.to_s.chars
  c.each_cons(n) do |t|
    tn = t.join("").to_i
    if a % tn == 0
      total += 1
    end
  end
  total
end

require "spec"
describe "findkbeauty" do
  it "test_ex1" do
    findkbeauty(240, 2).should eq 2
  end
  it "test_ex2" do
    findkbeauty(1020, 2).should eq 3
  end
  it "test_ex3" do
    findkbeauty(444, 2).should eq 0
  end
  it "test_ex4" do
    findkbeauty(17, 2).should eq 1
  end
  it "test_ex5" do
    findkbeauty(123, 1).should eq 2
  end
end
