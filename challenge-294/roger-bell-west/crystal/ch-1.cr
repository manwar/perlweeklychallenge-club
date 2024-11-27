#! /usr/bin/crystal


def consecutivesequence(a)
  b = a.sort
  mxlen = 0
  here = 0
  while true
    (here + 1).upto(b.size - 1) do |there|
      if b[there] != there - here + b[here]
        l = there - here
        if l > mxlen
          mxlen = l
        end
        here = there
        break
      end
      if there == b.size - 1
        l = there - here + 1
        if l > mxlen
          mxlen = l
        end
        here = there
        break
      end
    end
    if here >= b.size - 1
      break
    end
  end
  if mxlen < 2
    mxlen = -1
  end
  mxlen
end

require "spec"
describe "consecutivesequence" do
  it "test_ex1" do
    consecutivesequence([10, 4, 20, 1, 3, 2]).should eq 4
  end
  it "test_ex2" do
    consecutivesequence([0, 6, 1, 8, 5, 2, 4, 3, 0, 7]).should eq 9
  end
  it "test_ex3" do
    consecutivesequence([10, 30, 20]).should eq -1
  end
end
