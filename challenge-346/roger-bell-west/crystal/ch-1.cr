#! /usr/bin/crystal

def longestparenthesis(aa)
  a = aa.chars
  ml = 0
  0.upto(a.size - 1) do |l|
    l.upto(a.size - 1) do |r|
      depth = 0
      valid = true
      l.upto(r) do |i|
        if a[i] == '('
          depth += 1
        else
          depth -= 1
          if depth < 0
            valud = false
            break
          end
        end
      end
      if depth != 0
        valid = false
      end
      if valid
        ml = [ml, r - l + 1].max
      end
    end
  end
  ml
end

require "spec"
describe "longestparenthesis" do
  it "test_ex1" do
    longestparenthesis("(()())").should eq 6
  end
  it "test_ex2" do
    longestparenthesis(")()())").should eq 4
  end
  it "test_ex3" do
    longestparenthesis("((()))()(((()").should eq 8
  end
  it "test_ex4" do
    longestparenthesis("))))((()(").should eq 2
  end
  it "test_ex5" do
    longestparenthesis("()(()").should eq 2
  end
end
