#! /usr/bin/crystal

def maximumones(a)
  ax = a.map { |r| r.sum }
  am = ax.max
  ax.each_with_index do |n, i|
    if n == am
      return i + 1
    end
  end
  0
end

require "spec"
describe "#tmpl_var name=function>" do
  it "test_ex1" do
    maximumones([[0, 1], [1, 0]]).should eq 1
  end
  it "test_ex2" do
    maximumones([[0, 0, 0], [1, 0, 1]]).should eq 2
  end
  it "test_ex3" do
    maximumones([[0, 0], [1, 1], [0, 0]]).should eq 2
  end
end
