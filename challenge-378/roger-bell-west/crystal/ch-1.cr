#! /usr/bin/crystal

def secondlargestdigit(a)
  p = a.chars.select { |x| x >= '0' && x <= '9' }.to_set
  k = p.to_a.sort.reverse
  if k.size > 1
    k[1].to_i
  else
    -1
  end
end

require "spec"
describe "secondlargestdigit" do
  it "test_ex1" do
    secondlargestdigit("aaaaa77777").should eq -1
  end
  it "test_ex2" do
    secondlargestdigit("abcde").should eq -1
  end
  it "test_ex3" do
    secondlargestdigit("9zero8eight7seven9").should eq 8
  end
  it "test_ex4" do
    secondlargestdigit("xyz9876543210").should eq 8
  end
  it "test_ex5" do
    secondlargestdigit("4abc4def2ghi8jkl2").should eq 4
  end
end
