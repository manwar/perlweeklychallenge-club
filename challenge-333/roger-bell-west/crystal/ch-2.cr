#! /usr/bin/crystal

def duplicatezeros(a)
  b = Array(Int32).new
  a.each do |n|
    b.push(n)
    if a.size == b.size
      break
    end
    if n == 0
      b.push(0)
      if a.size == b.size
        break
      end
    end
  end
  b
end

require "spec"
describe "duplicatezeros" do
  it "test_ex1" do
    duplicatezeros([1, 0, 2, 3, 0, 4, 5, 0]).should eq [1, 0, 0, 2, 3, 0, 0, 4]
  end
  it "test_ex2" do
    duplicatezeros([1, 2, 3]).should eq [1, 2, 3]
  end
  it "test_ex3" do
    duplicatezeros([1, 2, 3, 0]).should eq [1, 2, 3, 0]
  end
  it "test_ex4" do
    duplicatezeros([0, 0, 1, 2]).should eq [0, 0, 0, 0]
  end
  it "test_ex5" do
    duplicatezeros([1, 2, 0, 3, 4]).should eq [1, 2, 0, 0, 3]
  end
end
