#! /usr/bin/crystal

def deleteandearn(a)
  ct = Hash(Int32, Int32).new(default_value: 0)
  a.each do |x|
    ct[x] += 1
  end
  mx = 0
  stack = Array(Tuple(Hash(Int32, Int32), Int32)).new
  stack.push({ct, 0})
  while stack.size > 0
    c = stack.pop
    if c[0].size == 0
      mx = [mx, c[1]].max
    else
      c[0].keys.each do |d|
        cc = c[0].clone
        cc[d] -= 1
        if cc[d] == 0
          cc.delete(d)
        end
        cc.delete(d - 1)
        cc.delete(d + 1)
        stack.push({cc, c[1] + d})
      end
    end
  end
  mx  
end

require "spec"
describe "deleteandearn" do
  it "test_ex1" do
    deleteandearn([3, 4, 2]).should eq 6
  end
  it "test_ex2" do
    deleteandearn([2, 2, 3, 3, 3, 4]).should eq 9
  end
end
