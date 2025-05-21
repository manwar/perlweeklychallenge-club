#! /usr/bin/crystal

def formatstring(a, n)
  p = a.chars.select{|x| x != '-'}
  r = p.size % n
  if r == 0
    r += n
  end
  o = ""
  p.each_with_index do |c, i|
    if r == i
      o += '-'
      r += n
    end
    o += c
  end
  o
end

require "spec"
describe "formatstring" do
  it "test_ex1" do
    formatstring("ABC-D-E-F", 3).should eq "ABC-DEF"
  end
  it "test_ex2" do
    formatstring("A-BC-D-E", 2).should eq "A-BC-DE"
  end
  it "test_ex3" do
    formatstring("-A-B-CD-E", 4).should eq "A-BCDE"
  end
end
