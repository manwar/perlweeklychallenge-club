#! /usr/bin/crystal

def straightline(a)
  b = a.to_set.to_a
  if b.size < 3
    return true
  end
  p = b[0][0]
  q = b[1][0] - b[0][0]
  r = b[0][1]
  s = b[1][1] - b[0][1]
  b[2, b.size].each do |tpair|
    if q == 0.0 && tpair[0] != b[0][0]
      return false
    end
    if s == 0.0 && tpair[1] != b[0][1]
      return false
    end
    if q != 0.0 && s != 0.0
      n1 = (tpair[0] - p) / q
      n2 = (tpair[1] - r) / s
      if n1 != n2
        return false
      end
    end
  end
  true
end

require "spec"
describe "straightline" do
  it "test_ex1" do
    straightline([[2, 1], [2, 3], [2, 5]]).should eq true
  end
  it "test_ex2" do
    straightline([[1, 4], [3, 4], [10, 4]]).should eq true
  end
  it "test_ex3" do
    straightline([[0, 0], [1, 1], [2, 3]]).should eq false
  end
  it "test_ex4" do
    straightline([[1, 1], [1, 1], [1, 1]]).should eq true
  end
end
