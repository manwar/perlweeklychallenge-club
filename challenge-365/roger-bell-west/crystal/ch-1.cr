#! /usr/bin/crystal

def alphabetindexdigitsum(a, k)
  st = ""
  a.chars.each do |c|
    st += (c.ord - 96).to_s
  end
  v = st.to_i
  1.upto(k) do
    j = 0
    while v > 0
      v, x = v.divmod(10)
      j += x
    end
    v = j
  end
  v
end

require "spec"
describe "alphabetindexdigitsum" do
  it "test_ex1" do
    alphabetindexdigitsum("abc", 1).should eq 6
  end
  it "test_ex2" do
    alphabetindexdigitsum("az", 2).should eq 9
  end
  it "test_ex3" do
    alphabetindexdigitsum("cat", 1).should eq 6
  end
  it "test_ex4" do
    alphabetindexdigitsum("dog", 2).should eq 8
  end
  it "test_ex5" do
    alphabetindexdigitsum("perl", 3).should eq 6
  end
end
