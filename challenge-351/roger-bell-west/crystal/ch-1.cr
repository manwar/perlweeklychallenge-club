#! /usr/bin/crystal

def specialaverage(a0)
  a = a0.sort
  min = a[0]
  max = a[-1]
  b = a.select{|x| x != min && x != max}
  if b.size == 0
    return 0
  end
  return b.sum / b.size
end

require "spec"
describe "specialaverage" do
  it "test_ex1" do
    specialaverage([8000, 5000, 6000, 2000, 3000, 7000]).should eq 5250
  end
  it "test_ex2" do
    specialaverage([100000, 80000, 110000, 90000]).should eq 95000
  end
  it "test_ex3" do
    specialaverage([2500, 2500, 2500, 2500]).should eq 0
  end
  it "test_ex4" do
    specialaverage([2000]).should eq 0
  end
  it "test_ex5" do
    specialaverage([1000, 2000, 3000, 4000, 5000, 6000]).should eq 3500
  end
end
