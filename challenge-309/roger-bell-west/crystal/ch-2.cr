#! /usr/bin/crystal

def mindiff(a)
  md = 0
  n = false
  0.upto(a.size - 2) do |i|
    (i + 1).upto(a.size - 1) do |j|
      diff = (a[i] - a[j]).abs
      if !n || diff < md
        md = diff
        n = true
      end
    end
  end
  md
end

require "spec"
describe "mindiff" do
  it "test_ex1" do
    mindiff([1, 5, 8, 9]).should eq 1
  end
  it "test_ex2" do
    mindiff([9, 4, 1, 7]).should eq 2
  end
end
