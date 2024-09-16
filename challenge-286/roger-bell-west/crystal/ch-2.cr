#! /usr/bin/crystal

def ordergame(a)
  p = a
  while p.size > 1
    q = [] of Int32
    mm = true
    p.each_slice(2) do |j|
      if mm
        q.push(j.min)
      else
        q.push(j.max)
      end
      mm = !mm
    end
    p = q
  end
  p[0]
end

require "spec"
describe "ordergame" do
  it "test_ex1" do
    ordergame([2, 1, 4, 5, 6, 3, 0, 2]).should eq 1
  end
  it "test_ex2" do
    ordergame([0, 5, 3, 2]).should eq 0
  end
  it "test_ex3" do
    ordergame([9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]).should eq 2
  end
end
