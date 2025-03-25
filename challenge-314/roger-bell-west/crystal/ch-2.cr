#! /usr/bin/crystal

def sortcolumn(a)
  vv = Array(Array(Char)).new
  a.each_with_index do |s, i|
    s.chars.each_with_index do |c, j|
      if i == 0
        vv.push(Array(Char).new)
      end
      vv[j].push(c)
    end
  end
  tot = 0
  vv.each do |x|
    y = x.sort
    if x != y
      tot += 1
    end
  end
  tot
end

require "spec"
describe "sortcolumn" do
  it "test_ex1" do
    sortcolumn(["swpc", "tyad", "azbe"]).should eq 2
  end
  it "test_ex2" do
    sortcolumn(["cba", "daf", "ghi"]).should eq 1
  end
  it "test_ex3" do
    sortcolumn(["a", "b", "c"]).should eq 0
  end
end
