#! /usr/bin/crystal

def brokenkeyboard(a, b)
  bk = Set.new(b.map{|x| x.downcase.chars[0]})
  ct = 0
  a.downcase.split(" ").each do |w|
    nk = Set.new(w.chars)
    if (bk & nk).size == 0
      ct += 1
    end
  end
  ct
end

require "spec"
describe "brokenkeyboard" do
  it "test_ex1" do
    brokenkeyboard("Hello World", ["d"]).should eq 1
  end
  it "test_ex2" do
    brokenkeyboard("apple banana cherry", ["a", "e"]).should eq 0
  end
  it "test_ex3" do
    brokenkeyboard("Coding is fun", [] of String).should eq 3
  end
  it "test_ex4" do
    brokenkeyboard("The Weekly Challenge", ["a", "b"]).should eq 2
  end
  it "test_ex5" do
    brokenkeyboard("Perl and Python", ["p"]).should eq 1
  end
end
