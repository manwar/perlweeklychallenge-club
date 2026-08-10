#! /usr/bin/crystal

def basen(a, base)
  if a == 0
    return "0"
  end
  digits = Array(Char).new
  c = '0'
  while c <= '9'
    digits.push(c)
    c += 1
  end
  c = 'A'
  while c <= 'Z'
    digits.push(c)
    c += 1
  end
  c = 'a'
  while c <= 'z'
    digits.push(c)
    c += 1
  end
  digits.push('+')
  digits.push('/')
  fields = Array(Int32).new
  aa = a
  while aa > 0
    aa, m = aa.divmod(base)
    fields.push(m)
  end
  output = ""
  while fields.size > 0
    output += digits[fields.pop]
  end
  output
end

require "spec"
describe "basen" do
  it "test_ex1" do
    basen(42, 2).should eq "101010"
  end
  it "test_ex2" do
    basen(15642094, 16).should eq "EEADEE"
  end
  it "test_ex3" do
    basen(493, 8).should eq "755"
  end
  it "test_ex4" do
    basen(2228519, 36).should eq "1BRJB"
  end
  it "test_ex5" do
    basen(123456789, 64).should eq "7MyqL"
  end
end
