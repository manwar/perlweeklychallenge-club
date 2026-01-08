#! /usr/bin/crystal

def mountainarray(a)
  state = 0
  a.each_cons(2) do |b|
    if b[1] > b[0]
      case state
      when 0, 1
        state = 1
      else
        return false
      end
    elsif b[1] < b[0]
      case state
      when 1, 2
        state = 2
      else
        return false
      end
    else
      return false
    end
  end
  return state == 2
end

require "spec"
describe "mountainarray" do
  it "test_ex1" do
    mountainarray([1, 2, 3, 4, 5]).should eq false
  end
  it "test_ex2" do
    mountainarray([0, 2, 4, 6, 4, 2, 0]).should eq true
  end
  it "test_ex3" do
    mountainarray([5, 4, 3, 2, 1]).should eq false
  end
  it "test_ex4" do
    mountainarray([1, 3, 5, 5, 4, 2]).should eq false
  end
  it "test_ex5" do
    mountainarray([1, 3, 2]).should eq true
  end
end
