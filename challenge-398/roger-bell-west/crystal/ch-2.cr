#! /usr/bin/crystal

def stringdifference(a)
  da = Array(Array(Int32)).new
  a.each do |s|
    p = Array(Int32).new
    s.chars.each_cons(2) do |d|
      p.push(d[1].ord - d[0].ord)
    end
    da.push(p)
  end
  dx = 0
  1.upto(a.size - 1) do |b|
    if da[0] != da[b]
      if dx > 0
        dx = 0
        break
      else
        dx = b
      end
    end
  end
  a[dx]
end

require "spec"
describe "stringdifference" do
  it "test_ex1" do
    stringdifference(["ab", "bc", "cd", "zy"]).should eq "zy"
  end
  it "test_ex2" do
    stringdifference(["cba", "fed", "azy"]).should eq "azy"
  end
  it "test_ex3" do
    stringdifference(["pop", "ada", "beb", "cfc"]).should eq "pop"
  end
  it "test_ex4" do
    stringdifference(["aaaa", "zzzz", "mmmm", "aaba"]).should eq "aaba"
  end
  it "test_ex5" do
    stringdifference(["aceg", "bdfh", "cegi", "azbz"]).should eq "azbz"
  end
end
