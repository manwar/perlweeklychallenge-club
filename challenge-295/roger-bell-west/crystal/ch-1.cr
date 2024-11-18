#! /usr/bin/crystal

def wordbreak(a, words)
  queue = [a]
  while queue.size > 0
    remnant = queue.shift
    if remnant.size == 0
      return true
    end
    words.each do |candidate|
      if remnant.index(candidate) == 0
        queue.push(remnant[candidate.size .. -1])
      end
    end
  end
  false
end

require "spec"
describe "wordbreak" do
  it "test_ex1" do
    wordbreak("weeklychallenge", ["challenge", "weekly"]).should eq true
  end
  it "test_ex2" do
    wordbreak("perlrakuperl", ["raku", "perl"]).should eq true
  end
  it "test_ex3" do
    wordbreak("sonsanddaughters", ["sons", "sand", "daughters"]).should eq false
  end
end
