#! /usr/bin/crystal

def acronyms(a, b)
  os = ""
  a.each do |c|
    os += c[0]
  end
  os == b
end

require "spec"
describe "acronyms" do
  it "test_ex1" do
    acronyms(["Perl", "Weekly", "Challenge"], "PWC").should eq true
  end
  it "test_ex2" do
    acronyms(["Bob", "Charlie", "Joe"], "BCJ").should eq true
  end
  it "test_ex3" do
    acronyms(["Morning", "Good"], "MM").should eq false
  end
end
