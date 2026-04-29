#! /usr/bin/crystal

def missingletter(a)
  c = a.chars.select{|x| x != ' '}.map{|x| x.ord}
  d = Array(Int32).new
  c.each_cons(2) do |i|
    if i[0] == 63 || i[1] == 63
      d.push(0)
    else
      d.push(i[1] - i[0])
    end
  end
  d.each_with_index do |delta, n|
    if delta == 0
      ch = 0
      if n < 2
        ch = c[n + 2] - d[n + 2]
      else
        ch = c[n] + d[n - 2]
      end
      return ch.chr.to_s
    end
  end
  ""
end

require "spec"
describe "missingletter" do
  it "test_ex1" do
    missingletter("a c ? g i").should eq "e"
  end
  it "test_ex2" do
    missingletter("a d ? j m").should eq "g"
  end
  it "test_ex3" do
    missingletter("a e ? m q").should eq "i"
  end
  it "test_ex4" do
    missingletter("a c f ? k").should eq "h"
  end
  it "test_ex5" do
    missingletter("b e g ? l").should eq "j"
  end
end
