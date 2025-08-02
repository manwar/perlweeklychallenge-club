#! /usr/bin/crystal

def semiorderedpermutation(a)
    en = a.size
    s = 1
    e = en - 1
    a.each_with_index do |n, i|
        if n == 1
            s = i
        end
        if n == en
            e = i
        end
    end
    r = s + (en - 1 - e)
    if s > e
        r -= 1
    end
    r
end

require "spec"
describe "semiorderedpermutation" do
  it "test_ex1" do
    semiorderedpermutation([2, 1, 4, 3]).should eq 2
  end
  it "test_ex2" do
    semiorderedpermutation([2, 4, 1, 3]).should eq 3
  end
  it "test_ex3" do
    semiorderedpermutation([1, 3, 2, 4, 5]).should eq 0
  end
end
