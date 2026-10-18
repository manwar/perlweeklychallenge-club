#! /usr/bin/crystal

def parsecomplex(a)
  re = Regex.new("^\\(?([-0-9]+)\\)?\\+\\(?([-0-9]+)\\)?i$")
  md = re.match(a)
  if md.nil?
    [0, 0]
  else
    c = Array(Int32).new
    1.upto(2) do |n|
      c.push(md[n].to_i)
    end
    c
  end
end

def complexnumber(aa, bb)
  a, b = parsecomplex(aa)
  c, d = parsecomplex(bb)
  ca =  a * c - b * d
  cb = a * d + b * c
  if cb >= 0
    ca.to_s + "+" + cb.to_s + "i"
  else
    ca.to_s + "+(" + cb.to_s + ")i"
  end
end

require "spec"
describe "complexnumber" do
  it "test_ex1" do
    complexnumber("1+1i", "1+1i").should eq "0+2i"
  end
  it "test_ex2" do
    complexnumber("1+(-1)i", "1+(-1)i").should eq "0+(-2)i"
  end
  it "test_ex3" do
    complexnumber("0+3i", "0+4i").should eq "-12+0i"
  end
  it "test_ex4" do
    complexnumber("3+4i", "3+(-4)i").should eq "25+0i"
  end
  it "test_ex5" do
    complexnumber("50+-20i", "-10+30i").should eq "100+1700i"
  end
end
