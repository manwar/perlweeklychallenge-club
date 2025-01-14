#! /usr/bin/crystal

def arrangebinary(a, n)
  b = a.clone
  t = n
  0.upto(b.size - 1) do |i|
    if b[i] == 0 &&
       (i == 0 || b[i - 1] == 0) &&
       (i == b.size - 1 || b[i + 1] == 0)
      b[i] = 1
      t -= 1
      if t == 0
        break
      end
    end
  end
  t == 0
end

require "spec"
describe "arrangebinary" do
  it "test_ex1" do
    arrangebinary([1, 0, 0, 0, 1], 1).should eq true
  end
  it "test_ex2" do
    arrangebinary([1, 0, 0, 0, 1], 2).should eq false
  end
end
