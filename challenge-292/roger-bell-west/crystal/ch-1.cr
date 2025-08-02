#! /usr/bin/crystal

def twicelargest(a)
  p = a.sort.reverse
  if p[0] >= 2 * p[1]
    a.each_with_index do |c, i|
      if c == p[0]
        return i
      end
    end
  end
  -1
end

require "spec"
describe "twicelargest" do
  it "test_ex1" do
    twicelargest([2, 4, 1, 0]).should eq 1
  end
  it "test_ex2" do
    twicelargest([1, 2, 3, 4]).should eq -1
  end
end
