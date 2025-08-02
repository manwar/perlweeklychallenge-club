#! /usr/bin/crystal

def lastelement(a)
  b = a
  while true
    b.sort!
    f = b.pop
    s = b.pop
    if f > s
      b.push(f - s)
    end
    if b.size == 0
      return 0
    end
    if b.size == 1
      return b[0]
    end
  end
end

require "spec"
describe "lastelement" do
  it "test_ex1" do
    lastelement([3, 8, 5, 2, 9, 2]).should eq 1
  end
  it "test_ex2" do
    lastelement([3, 2, 5]).should eq 0
  end
end
