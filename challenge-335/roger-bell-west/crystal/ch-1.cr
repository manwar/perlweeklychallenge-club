#! /usr/bin/crystal

def counterify(a)
  cc = Hash(Char, Int32).new(default_value: 0)
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def commoncharacters(a)
  mc = Hash(Char, Int32).new
  first = true
  a.each do |s|
    mk = counterify(s.chars)
    if first
      mc = mk
      first = false
    else
      mc.keys.each do |k|
        if mk.has_key?(k)
          mc[k] = [mc[k], mk[k]].min
        else
          mc.delete(k)
        end
      end
    end
  end
  out = Array(String).new
  mc.keys.sort.each do |c|
    1.upto(mc[c]) do
      out.push(c.to_s)
    end
  end
  out
end

require "spec"
describe "commoncharacters" do
  it "test_ex1" do
    commoncharacters(["bella", "label", "roller"]).should eq ["e", "l", "l"]
  end
  it "test_ex2" do
    commoncharacters(["cool", "lock", "cook"]).should eq ["c", "o"]
  end
  it "test_ex3" do
    commoncharacters(["hello", "world", "pole"]).should eq ["l", "o"]
  end
  it "test_ex4" do
    commoncharacters(["abc", "def", "ghi"]).should eq Array(String).new
  end
  it "test_ex5" do
    commoncharacters(["aab", "aac", "aaa"]).should eq ["a", "a"]
  end
end
