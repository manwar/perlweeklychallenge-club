#! /usr/bin/crystal

def subsequence(a, b)
  l = a
  s = b
  if a.size < b.size
    l = b
    s = a
  end
  st = s.chars()
  si = 0
  l.each_char do |c|
    if c == st[si]
      si += 1
      if si >= st.size
        return true
      end
    end
  end
  false
end

require "spec"
describe "subsequence" do
  it "test_ex1" do
    subsequence("uvw", "bcudvew").should eq true
  end
  it "test_ex2" do
    subsequence("aec", "abcde").should eq false
  end
  it "test_ex3" do
    subsequence("sip", "javascript").should eq true
  end
end
