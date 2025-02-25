#! /usr/bin/crystal

def mingap(a)
  mg = a[-1] - a[0]
  mv = 0
  a.each_cons(2) do |p|
    delta = p[1] - p[0]
    if delta < mg
      mg = delta
      mv = p[1]
    end
  end
  mv
end

require "spec"
describe "mingap" do
  it "test_ex1" do
    mingap([2, 8, 10, 11, 15]).should eq 11
  end
  it "test_ex2" do
    mingap([1, 5, 6, 7, 14]).should eq 6
  end
  it "test_ex3" do
    mingap([8, 20, 25, 28]).should eq 28
  end
end
