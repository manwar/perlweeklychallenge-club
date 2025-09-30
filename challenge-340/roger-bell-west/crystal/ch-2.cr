#! /usr/bin/crystal

def ascendingnumbers(a)
  prev = nil
  a.split(" ").each do |c|
    n = c.to_i?
    if !n.nil?
      if !prev.nil? && prev >= n
        return false
      end
      prev = n
    end
  end
  true
end

require "spec"
describe "ascendingnumbers" do
  it "test_ex1" do
    ascendingnumbers("The cat has 3 kittens 7 toys 10 beds").should eq true
  end
  it "test_ex2" do
    ascendingnumbers("Alice bought 5 apples 2 oranges 9 bananas").should eq false
  end
  it "test_ex3" do
    ascendingnumbers("I ran 1 mile 2 days 3 weeks 4 months").should eq true
  end
  it "test_ex4" do
    ascendingnumbers("Bob has 10 cars 10 bikes").should eq false
  end
  it "test_ex5" do
    ascendingnumbers("Zero is 0 one is 1 two is 2").should eq true
  end
end
