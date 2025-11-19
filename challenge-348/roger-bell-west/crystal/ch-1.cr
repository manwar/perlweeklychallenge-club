#! /usr/bin/crystal

def stringalike(a)
  if a.size % 2 == 1
    return false
  end
  vt = 0
  mode = 1
  av = false
  a.downcase.chars.each_with_index do |c, i|
    if i * 2 == a.size
      mode = -1
    end
    if c.in_set?("aeiou")
      vt += mode
      av = true
    end
  end
  av && (vt == 0)
end

require "spec"
describe "stringalike" do
  it "test_ex1" do
    stringalike("textbook").should eq false
  end
  it "test_ex2" do
    stringalike("book").should eq true
  end
  it "test_ex3" do
    stringalike("AbCdEfGh").should eq true
  end
  it "test_ex4" do
    stringalike("rhythmmyth").should eq false
  end
  it "test_ex5" do
    stringalike("UmpireeAudio").should eq false
  end
end
