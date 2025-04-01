#! /usr/bin/crystal

def equalstrings(a)
  ca = a.map { |x| x.chars() }.to_set.to_a
  mmlen = ca.map { |x| x.size }.min
  si = 0
  0.upto(mmlen - 1) do |i|
    si = i
    1.upto(ca.size - 1) do |s|
      if ca[0][i] != ca[s][i]
        if i == 0
          return -1
        end
        si -= 1
        break
      end
    end
  end
  a.map { |x| x.size }.sum - a.size * (si + 1)
end

require "spec"
describe "equalstrings" do
  it "test_ex1" do
    equalstrings(["abc", "abb", "ab"]).should eq 2
  end
  it "test_ex2" do
    equalstrings(["ayz", "cyz", "xyz"]).should eq -1
  end
  it "test_ex3" do
    equalstrings(["yza", "yzb", "yzc"]).should eq 3
  end
end
