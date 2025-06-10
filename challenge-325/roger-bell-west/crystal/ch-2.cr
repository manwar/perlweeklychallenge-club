#! /usr/bin/crystal

def finalprice(a)
  out = Array(Int32).new
  a.each_with_index do |n, i|
    discount = 0
    (i + 1).upto(a.size - 1) do |mi|
      if a[mi] <= n
        discount = a[mi]
        break
      end
    end
    out.push(n - discount)
  end
  out
end

require "spec"
describe "finalprice" do
  it "test_ex1" do
    finalprice([8, 4, 6, 2, 3]).should eq [4, 2, 4, 2, 3]
  end
  it "test_ex2" do
    finalprice([1, 2, 3, 4, 5]).should eq [1, 2, 3, 4, 5]
  end
  it "test_ex3" do
    finalprice([7, 1, 1, 5]).should eq [6, 0, 1, 5]
  end
end
