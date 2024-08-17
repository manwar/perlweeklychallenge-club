#! /usr/bin/crystal

def percentageofcharacter(a, c)
  d = a.size
  n = 100 * a.count(c)
  (n + d // 2) // d
end

require "spec"
describe "" do
  it "test_ex1" do
    percentageofcharacter("perl", 'e').should eq 25
  end
  it "test_ex2" do
    percentageofcharacter("java", 'a').should eq 50
  end
  it "test_ex3" do
    percentageofcharacter("python", 'm').should eq 0
  end
  it "test_ex4" do
    percentageofcharacter("ada", 'a').should eq 67
  end
  it "test_ex5" do
    percentageofcharacter("ballerina", 'l').should eq 22
  end
  it "test_ex6" do
    percentageofcharacter("analitik", 'k').should eq 13
  end
end
