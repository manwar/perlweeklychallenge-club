#! /usr/bin/crystal

def findthird(s, a, b)
  ss = Array(String).new
  sa = ""
  s.chars.each do |c|
    cc = c.downcase
    if c >= 'a' && c <= 'z'
      sa += c
    else
      if sa.size > 0
        ss.push(sa)
        sa = ""
      end
    end
  end
  if sa.size > 0
    ss.push(sa)
  end
  out = Array(String).new
  ss.each_cons(3) do |p|
    if p[0] == a && p[1] == b
      out.push(p[2])
    end
  end
  out
end

require "spec"
describe "findthird" do
  it "test_ex1" do
    findthird("Perl is a my favourite language but Python is my favourite too.", "my", "favourite").should eq ["language", "too"]
  end
  it "test_ex2" do
    findthird("Barbie is a beautiful doll also also a beautiful princess.", "a", "beautiful").should eq ["doll", "princess"]
  end
  it "test_ex3" do
    findthird("we will we will rock you rock you.", "we", "will").should eq ["we", "rock"]
  end
end
