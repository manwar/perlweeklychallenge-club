#! /usr/bin/crystal

def is_palindrome(a)
  l = a.size
  0.upto((l/2).to_i) do |i|
    if a[i] != a[l - i - 1]
      return false
    end
  end
  true
end

def convertpalindrome(a)
  c0 = a.chars
  i = 0
  while true
    c = c0.clone
    0.upto(i - 1) do |n|
      c.unshift(c0[c0.size - i + n])
    end
    if is_palindrome(c)
      return c.join("")
    end
    i += 1
  end
end

require "spec"
describe "convertpalindrome" do
  it "test_ex1" do
    convertpalindrome("pinnipeds").should eq "sdepinnipeds"
  end
  it "test_ex2" do
    convertpalindrome("abcd").should eq "dcbabcd"
  end
  it "test_ex3" do
    convertpalindrome("bananas").should eq "sananabananas"
  end
  it "test_ex4" do
    convertpalindrome("dissident").should eq "tnedissident"
  end
  it "test_ex5" do
    convertpalindrome("cailliachs").should eq "shcailliachs"
  end
end
