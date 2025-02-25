#! /usr/bin/crystal
require "spec"

def maximalsquare(a)
  mx = 0
  boundy = a.size
  boundx = a[0].size
  0.upto(boundy - 1) do |y|
    0.upto(boundx - 1) do |x|
      size = 0
      while true
        tests = [] of Array(Int32)
        x.upto(x + size) do |xx|
          tests.push([y + size, xx])
        end
        if size > 0
          y.upto(y + size - 1) do |yy|
            tests.push([yy, x + size])
          end
        end
        if tests.map { |yx| a[yx[0]][yx[1]] }.any?{|n| n == 0}
          break
        end
        size += 1
        if x + size >= boundx || y + size >= boundy
          break
        end
      end
      mx = [mx, size * size].max
    end
  end
  mx
end

describe "maximalsquare" do
  it "test_ex1" do
    maximalsquare([[1, 0, 1, 0, 0], [1, 0, 1, 1, 1], [1, 1, 1, 1, 1], [1, 0, 0, 1, 0]]).should eq 4
  end
  it "test_ex2" do
    maximalsquare([[0, 1], [1, 0]]).should eq 1
  end
  it "test_ex3" do
    maximalsquare([[0]]).should eq 0
  end
end
