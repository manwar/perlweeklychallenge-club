#! /usr/bin/crystal

def pythagorasmultiplied(n)
  squared = Hash(Int32, Int32).new
  ct = 0
  5.upto(n) do |c|
    unless squared.has_key?(c)
      squared[c] = c * c
    end
    1.upto(c - 2) do |a|
      unless squared.has_key?(a)
        squared[a] = a * a
      end
      (a + 1).upto(c - 1) do |b|
        unless squared.has_key?(b)
          squared[b] = b * b
        end
        tot = squared[a] + squared[b]
        if tot > squared[c]
          break
        end
        if tot == squared[c]
          ct += 1
        end
      end
    end
  end
  ct * 2
end

require "spec"
describe "pythagorasmultiplied" do
  it "test_ex1" do
    pythagorasmultiplied(20).should eq 12
  end
  it "test_ex2" do
    pythagorasmultiplied(7).should eq 2
  end
  it "test_ex3" do
    pythagorasmultiplied(1).should eq 0
  end
  it "test_ex4" do
    pythagorasmultiplied(15).should eq 8
  end
  it "test_ex5" do
    pythagorasmultiplied(30).should eq 22
  end
end
