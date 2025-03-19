#! /usr/bin/crystal

def reverseletters(a)
  vout = Array.new(a.size, ' ')
  letterslots = Array(Int32).new
  letters = Array(Char).new
  a.chars().each_with_index do |c, i|
    if c.ascii_letter?
      letterslots.push(i)
      letters.push(c)
    else
      vout[i] = c
    end
  end
  letterslots.each do |i|
    vout[i] = letters.pop()
  end
  vout.join("")
end

require "spec"
describe "reverseletters" do
  it "test_ex1" do
    reverseletters("p-er?l").should eq "l-re?p"
  end
  it "test_ex2" do
    reverseletters("wee-k!L-y").should eq "yLk-e!e-w"
  end
  it "test_ex3" do
    reverseletters("_c-!h_all-en!g_e").should eq "_e-!g_nel-la!h_c"
  end
end
