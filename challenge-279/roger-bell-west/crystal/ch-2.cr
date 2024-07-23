#! /usr/bin/crystal
require "spec"
describe "splitstring" do
  it "test_ex1" do
    splitstring("perl").should eq false
  end
  it "test_ex2" do
    splitstring("book").should eq true
  end
  it "test_ex3" do
    splitstring("goodmorning").should eq true
  end
end

def splitstring(a)
  n = 0
  a.downcase.chars.each do |cc|
    n += case cc
         when 'a', 'e', 'i', 'o', 'u'
           1
         else
           0
         end
  end
  n % 2 == 0
end
