#! /usr/bin/crystal

def wordslengthproduct(a)
  ws = a.map{|x| x.chars.to_set}
  mx = 0
  0.upto(ws.size - 2) do |i|
    i.upto(ws.size - 1) do |j|
      if (ws[i] & ws[j]).size == 0
         mx = [mx, a[i].size * a[j].size].max
      end
    end
  end
  mx
end

require "spec"
describe "wordslengthproduct" do
  it "test_ex1" do
    wordslengthproduct(["a", "ab", "abc", "d", "de", "def"]).should eq 9
  end
  it "test_ex2" do
    wordslengthproduct(["a", "aa", "aaa", "aaaa"]).should eq 0
  end
  it "test_ex3" do
    wordslengthproduct(["meet", "app", "code", "sky", "bold"]).should eq 16
  end
  it "test_ex4" do
    wordslengthproduct(["a", "ab", "abc", "abcd", "efghi"]).should eq 20
  end
  it "test_ex5" do
    wordslengthproduct(["xyz", "w", "abcdefg", "hij"]).should eq 21
  end
end
