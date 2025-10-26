#! /usr/bin/crystal

def arrayformation(src, tgt)
  stack = Array(Tuple(Array(Int32), Set(Int32))).new
  stack.push({Array(Int32).new, 0.upto(src.size - 1).to_set})
  while stack.size > 0
    c = stack.pop
    if c[0].size == tgt.size()
      return true
    else
      c[1].each do |candidate|
        offset = c[0].size
        nextcandidate = c[1].clone
        nextcandidate.delete(candidate)
        valid = true
        seq = c[0].clone
        src[candidate].each_with_index do |x, i|
          if x == tgt[i + offset]
            seq.push(x)
          else
            valid = false
            break
          end
        end
        if valid
          stack.push({seq, nextcandidate})
        end
      end
    end
  end
  false
end

require "spec"
describe "arrayformation" do
  it "test_ex1" do
    arrayformation([[2, 3], [1], [4]], [1, 2, 3, 4]).should eq true
  end
  it "test_ex2" do
    arrayformation([[1, 3], [2, 4]], [1, 2, 3, 4]).should eq false
  end
  it "test_ex3" do
    arrayformation([[9, 1], [5, 8], [2]], [5, 8, 2, 9, 1]).should eq true
  end
  it "test_ex4" do
    arrayformation([[1], [3]], [1, 2, 3]).should eq false
  end
  it "test_ex5" do
    arrayformation([[7, 4, 6]], [7, 4, 6]).should eq true
  end
end
