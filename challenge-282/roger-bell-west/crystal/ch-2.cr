#! /usr/bin/crystal
require "spec"
describe "changingkeys" do
  it "test_ex1" do
    changingkeys("pPeERrLl").should eq 3
  end
  it "test_ex2" do
    changingkeys("rRr").should eq 0
  end
  it "test_ex3" do
    changingkeys("GoO").should eq 1
  end
end

def changingkeys(a)
  oc = 'x'
  out = 0
  a.downcase.chars.each_with_index do |c, i|
    if i == 0
      oc = c
    elsif c != oc
      oc = c
      out += 1
    end
  end
  out
end
