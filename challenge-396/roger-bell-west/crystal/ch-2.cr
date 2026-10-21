#! /usr/bin/crystal

def trionicarray(a)
  state = 0
  prev = a[0]
  a.skip(1).each do |n|
    dir = 0
    if n > prev
      dir = 1
    elsif n < prev
      dir = -1
    end
    if dir == 0
      return false
    end
    case state
    when 0
      if dir == 1
        state = 1
      else
        return false
      end
    when 1
      if dir == -1
        state = 2
      end
    when 2
      if dir == 1
        state = 3
      end
    when 3
      if dir == -1
        return false
      end
    else
      return false
    end
    prev = n
  end
  state == 3
end

require "spec"
describe "trionicarray" do
  it "test_ex1" do
    trionicarray([1, 3, 5, 4, 2, 6, 8]).should eq true
  end
  it "test_ex2" do
    trionicarray([1, 4, 4, 2, 1, 3, 5]).should eq false
  end
  it "test_ex3" do
    trionicarray([2, 10, 3, 1, 9]).should eq true
  end
  it "test_ex4" do
    trionicarray([1, 2, 3, 4, 3, 2, 1]).should eq false
  end
  it "test_ex5" do
    trionicarray([1, 3, 2, 4, 1, 5, 2]).should eq false
  end
end
