#! /usr/bin/crystal

def secretsanta(n)
  case n
  when 0
    1
  when 1
    0
  else
    (n - 1) * (secretsanta(n - 1) + secretsanta(n - 2))
  end
end

require "spec"
describe "secretsanta" do
  it "test_ex1" do
    secretsanta(1).should eq 0
  end
  it "test_ex2" do
    secretsanta(2).should eq 1
  end
  it "test_ex3" do
    secretsanta(3).should eq 2
  end
  it "test_ex4" do
    secretsanta(4).should eq 9
  end
  it "test_ex5" do
    secretsanta(5).should eq 44
  end
end
