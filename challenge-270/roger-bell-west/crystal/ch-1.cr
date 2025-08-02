#! /usr/bin/crystal

def validator(a0 : Array(Int32)) : Int32?
  a = a0.sort
  l = a.size
  if a[0] == 0  && a[l - 2] == 0 && a[l - 1] == 1
    (0 ... l).each do |i|
      if a0[i] == 1
        return i
      end
    end
  end
  nil
end

def specialpositions(a : Array(Array(Int32))) : Int32
  vr = Set(Tuple(Int32, Int32)).new
  xs = Set(Int32).new
  a.each_with_index do |row, y|
    x = validator(row) || -1
    if x
      vr.add({y, x})
      xs.add(x)
    end
  end
  xd = Set(Int32).new
  xs.each do |x|
    c = a.map { |r| r[x] }
    unless validator(c)
      xd.add(x)
    end
  end
  xs -= xd
  vr.select { | (y, x) | xs.includes?(x) }.size
end
  
require "spec"
describe "#tmpl_var name=function>" do
  it "test_ex1" do
    specialpositions([[1, 0, 0], [0, 0, 1], [1, 0, 0]]).should eq 1
  end
  it "test_ex2" do
    specialpositions([[1, 0, 0], [0, 1, 0], [0, 0, 1]]).should eq 3
  end
end
