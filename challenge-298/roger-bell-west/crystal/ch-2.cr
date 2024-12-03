#! /usr/bin/crystal
require "spec"

def rightinterval(a)
  ss = a.map{|x| x[0]}
  si = (0 ... a.size).to_a.sort_by{|i| ss[i]}
  out = [] of Int32
  a.each do |l|
    ix = si.select{|i| ss[i] >= l[1]}
    if ix.size == 0
      out.push(-1)
    else
      out.push(ix[0])
    end
  end
  out
end

describe "rightinterval" do
  it "test_ex1" do
    rightinterval([[3, 4], [2, 3], [1, 2]]).should eq [-1, 0, 1]
  end
  it "test_ex2" do
    rightinterval([[1, 4], [2, 3], [3, 4]]).should eq [-1, 2, -1]
  end
  it "test_ex3" do
    rightinterval([[1, 2]]).should eq [-1]
  end
  it "test_ex4" do
    rightinterval([[1, 4], [2, 2], [3, 4]]).should eq [-1, 1, -1]
  end
end
