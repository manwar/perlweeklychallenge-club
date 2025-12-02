#! /usr/bin/crystal

def counterify(a)
  cc = Hash(Char, Int32).new(default_value: 0)
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def countdigits(a)
  counterify(a.to_s.chars)
end

def shufflepairs(low, high, pairs)
  total = 0
  low.upto(high) do |candidate|
    candidatec = countdigits(candidate)
    cnt = 0
    2.upto(9) do |mul|
      test = candidate * mul
      testc = countdigits(test)
      if testc == candidatec
        cnt += 1
        if cnt >= pairs
          break
        end
      end
    end
    if cnt >= pairs
      total += 1
    end
  end
  total
end

require "spec"
describe "shufflepairs" do
  it "test_ex1" do
    shufflepairs(1, 1000, 1).should eq 0
  end
  it "test_ex2" do
    shufflepairs(1500, 2500, 1).should eq 3
  end
  it "test_ex3" do
    shufflepairs(1000000, 1500000, 5).should eq 2
  end
  it "test_ex4" do
    shufflepairs(13427000, 14100000, 2).should eq 11
  end
  it "test_ex5" do
    shufflepairs(1000, 5000, 1).should eq 7
  end
end
