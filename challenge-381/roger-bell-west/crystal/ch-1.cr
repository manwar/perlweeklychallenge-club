#! /usr/bin/crystal

def samerowcolumn(a)
  a.each do |row|
    notfound = 1.upto(row.size).to_set
    row.each do |n|
      notfound.delete(n)
    end
    if notfound.size > 0
      return false
    end
  end
  0.upto(a[0].size - 1) do |coln|
    notfound = 1.upto(a.size).to_set
    a.each do |row|
      notfound.delete(row[coln])
    end
    if notfound.size > 0
      return false
    end
  end
  true
end

require "spec"
describe "samerowcolumn" do
  it "test_ex1" do
    samerowcolumn([[1, 2, 3, 4], [2, 3, 4, 1], [3, 4, 1, 2], [4, 1, 2, 3]]).should eq true
  end
  it "test_ex2" do
    samerowcolumn([[1]]).should eq true
  end
  it "test_ex3" do
    samerowcolumn([[1, 2, 5], [5, 1, 2], [2, 5, 1]]).should eq false
  end
  it "test_ex4" do
    samerowcolumn([[1, 2, 3], [1, 2, 3], [1, 2, 3]]).should eq false
  end
  it "test_ex5" do
    samerowcolumn([[1, 2, 3], [3, 1, 2], [3, 2, 1]]).should eq false
  end
end
