#! /usr/bin/crystal

def thousandseparator(a)
  out = ""
  s = a.to_s
  offset = 2 - ((s.size + 2) % 3)
  s.chars.each_with_index do |d, i|
    if i > 0 && (i + offset) % 3 == 0
      out += ','
    end
    out += d
  end
  out
end

require "spec"
describe "thousandseparator" do
  it "test_ex1" do
    thousandseparator(123).should eq "123"
  end
  it "test_ex2" do
    thousandseparator(1234).should eq "1,234"
  end
  it "test_ex3" do
    thousandseparator(1000000).should eq "1,000,000"
  end
  it "test_ex4" do
    thousandseparator(1).should eq "1"
  end
  it "test_ex5" do
    thousandseparator(12345).should eq "12,345"
  end
end
