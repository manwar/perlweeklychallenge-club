#! /usr/bin/crystal

def titlecapital(a)
  out = Array(String).new
  a.split(" ").each do |w|
    p = w.downcase
    if p.size > 2
      c = p.chars
      c[0] = c[0].upcase
      p = c.join("")
    end
    out.push(p)
  end
  out.join(" ")
end

require "spec"
describe "titlecapital" do
  it "test_ex1" do
    titlecapital("PERL IS gREAT").should eq "Perl is Great"
  end
  it "test_ex2" do
    titlecapital("THE weekly challenge").should eq "The Weekly Challenge"
  end
  it "test_ex3" do
    titlecapital("YoU ARE A stAR").should eq "You Are a Star"
  end
end
