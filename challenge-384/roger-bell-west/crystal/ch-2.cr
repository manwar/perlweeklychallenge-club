#! /usr/bin/crystal

def specialbinarysubstrings(a)
  out = Array(String).new
  ac = a.chars
  0.upto(ac.size - 2) do |i|
    (i+1).step(to: ac.size - 1, by: 2) do |j|
      lastchar = 'x'
      switches = 0
      balance = 0
      outstr = ""
      i.upto(j) do |ct|
        if ac[ct] != lastchar
          switches += 1
          lastchar = ac[ct]
        end
        if ac[ct] == '0'
          balance -= 1
        else
          balance += 1
        end
        outstr += ac[ct]
      end
      if balance == 0 && switches == 2
        out.push(outstr)
      end
    end
  end
  out
end

require "spec"
describe "specialbinarysubstrings" do
  it "test_ex1" do
    specialbinarysubstrings("0101").should eq ["01", "10", "01"]
  end
  it "test_ex2" do
    specialbinarysubstrings("000111").should eq ["000111", "0011", "01"]
  end
  it "test_ex3" do
    specialbinarysubstrings("000011").should eq ["0011", "01"]
  end
  it "test_ex4" do
    specialbinarysubstrings("10011100").should eq ["10", "0011", "01", "1100", "10"]
  end
  it "test_ex5" do
    specialbinarysubstrings("00000").should eq Array(String).new
  end
end
