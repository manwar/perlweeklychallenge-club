#! /usr/bin/crystal

def groupdigitsum(a, sz)
  s = a
  n = 0
  while true
    t = ""
    s.chars.each_with_index do |c, i|
      n += c.to_i
      if i == s.size - 1 || (i + 1) % sz == 0
        t += n.to_s
        n = 0
      end
    end
    s = t
    if s.size <= sz
      break
    end
  end
  s
end

require "spec"
describe "groupdigitsum" do
  it "test_ex1" do
    groupdigitsum("111122333", 3).should eq "359"
  end
  it "test_ex2" do
    groupdigitsum("1222312", 2).should eq "76"
  end
  it "test_ex3" do
    groupdigitsum("100012121001", 4).should eq "162"
  end
end
