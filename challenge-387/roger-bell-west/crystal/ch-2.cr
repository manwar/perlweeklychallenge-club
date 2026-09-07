#! /usr/bin/crystal

def atomscount(a)
  i = 0
  stack = [Hash(String, Int32).new(default_value: 0)]
  while i < a.size
    sa = a[i..]
    if caps = /^([A-Z][a-z]?)([0-9]+)/.match(sa)
      element = caps[1]
      ct = caps[2].to_i
      stack[-1][element] += ct
      i += caps[0].size
    elsif caps = /^([A-Z][a-z]?)/.match(sa)
      element = caps[1]
      stack[-1][element] += 1
      i += caps[0].size
    elsif sa.match(/^\(/)
      stack.push(Hash(String, Int32).new(default_value: 0))
      i += 1
    elsif caps = /^\)([0-9]+)/.match(sa)
      ct = caps[1].to_i
      oc = stack.pop
      oc.each do |k, v|
        stack[-1][k] += v * ct
      end
      i += caps[0].size
    end
  end
  outstr = ""
  stack[0].keys.sort.each do |k|
    outstr += k
    if stack[0][k] > 1
      outstr += stack[0][k].to_s
    end
  end
  outstr
end

require "spec"
describe "atomscount" do
  it "test_ex1" do
    atomscount("((N2O)3(H2O)2)2").should eq "H8N12O10"
  end
  it "test_ex2" do
    atomscount("Mg3(PO4)2").should eq "Mg3O8P2"
  end
  it "test_ex3" do
    atomscount("(((H)2)3)4").should eq "H24"
  end
  it "test_ex4" do
    atomscount("NaCl3(O2(S10)2)2Mg").should eq "Cl3MgNaO4S40"
  end
  it "test_ex5" do
    atomscount("Z2Y3(X2W)2").should eq "W2X4Y3Z2"
  end
end
