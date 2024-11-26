#! /usr/bin/crystal

def contiguousarray(a)
  ((a.size + 1) // 2 * 2).step(to: 2, by: -2) do |l|
    0.upto(a.size - l) do |start|
      if a[start: start, count: l].sum * 2 == l
        return l
      end
    end
  end
  0
end

require "spec"
describe "contiguousarray" do
  it "test_ex1" do
    contiguousarray([1, 0]).should eq 2
  end
  it "test_ex2" do
    contiguousarray([0, 1, 0]).should eq 2
  end
  it "test_ex3" do
    contiguousarray([0, 0, 0, 0, 0]).should eq 0
  end
  it "test_ex4" do
    contiguousarray([0, 1, 0, 0, 1, 0]).should eq 4
  end
end
