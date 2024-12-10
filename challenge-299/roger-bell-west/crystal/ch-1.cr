#! /usr/bin/crystal

def replacewords(ww, a)
  out = [] of String
  a.split(' ').each do |w|
    r = false
    ww.each do |lw|
      if w.index(lw) == 0
        out.push(lw)
        r = true
        break
      end
    end
    if !r
      out.push(w)
    end
  end
  out.join(' ')
end
require "spec"
describe "replacewords" do
  it "test_ex1" do
    replacewords(["cat", "bat", "rat"], "the cattle was rattle by the battery").should eq "the cat was rat by the bat"
  end
  it "test_ex2" do
    replacewords(["a", "b", "c"], "aab aac and cac bab").should eq "a a a c b"
  end
  it "test_ex3" do
    replacewords(["man", "bike"], "the manager was hit by a biker").should eq "the man was hit by a bike"
  end
end
