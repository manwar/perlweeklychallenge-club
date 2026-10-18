#! /usr/bin/crystal

def wordsquares(a)
  l = a[0].size
  words = a.to_set
  queue = Deque(Array(String)).new
  a.each do |w|
    queue.push([w])
  end
  while queue.size > 0
    p = queue.shift
    if p.size == l
      return p
    end
    (words - p.to_set).each do |ca|
      valid = true
      ca.chars.each_with_index do |c, i|
        if i >= p.size
          break
        end
        if c != p[i][p.size]
          valid = false
          break
        end
      end
      if valid
        pw = p.clone
        pw.push(ca)
        queue.push(pw)
      end
    end
  end
  Array(String).new
end

require "spec"
describe "wordsquares" do
  it "test_ex1" do
    wordsquares(["MA", "AM", "MY", "ME"]).should eq ["MA", "AM"]
  end
  it "test_ex2" do
    wordsquares(["SUN", "USE", "NET", "SEE", "TEN"]).should eq ["SUN", "USE", "NET"]
  end
  it "test_ex3" do
    wordsquares(["BOAT", "TEAL", "AREA", "TSAR", "OGRE"]).should eq ["BOAT", "OGRE", "AREA", "TEAL"]
  end
  it "test_ex4" do
    wordsquares(["CARD", "AREA", "REAR", "DART"]).should eq ["CARD", "AREA", "REAR", "DART"]
  end
  it "test_ex5" do
    wordsquares(["HEART", "TREND", "EMBER", "RESIN", "ABUSE"]).should eq ["HEART", "EMBER", "ABUSE", "RESIN", "TREND"]
  end
end
