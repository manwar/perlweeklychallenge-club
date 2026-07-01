#! /usr/bin/crystal

def counterify(a)
  cc = Hash(Char, Int32).new(default_value: 0)
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def sumoffrequencies(a)
  vw = 0
  cn = 0
  cc = counterify(a.chars)
  cv = cc.values.sort.reverse
  cv.each do |n|
    cc.select { |c, ni| ni == n }.each do |c, _|
      case c
      when 'a', 'e', 'i', 'o', 'u'
        if vw == 0
          vw = n
        end
      else
        if cn == 0
          cn = n
        end
      end
    end
    if vw > 0 && cn > 0
      break
    end
  end
  vw + cn
end

require "spec"
describe "sumoffrequencies" do
  it "test_ex1" do
    sumoffrequencies("banana").should eq 5
  end
  it "test_ex2" do
    sumoffrequencies("teestett").should eq 7
  end
  it "test_ex3" do
    sumoffrequencies("aeiouuaa").should eq 3
  end
  it "test_ex4" do
    sumoffrequencies("rhythm").should eq 2
  end
  it "test_ex5" do
    sumoffrequencies("x").should eq 1
  end
end
