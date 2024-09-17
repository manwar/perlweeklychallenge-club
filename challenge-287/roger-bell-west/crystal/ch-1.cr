#! /usr/bin/crystal

def strongpassword(a)
  ctypes = Hash(Char, Int32).new(default_value: 0)
  reps = 0
  rep = 0
  old = '@'
  changes = Array(Int32).new
  a.chars.each_with_index do |c, i|
    if i > 0 && c == old 
      rep += 1
      if rep >= 2 
        reps += 1
      end
    else
      rep = 0
      old = c
    end
    t = 'n'
    if c.ascii_uppercase?
      t = 'u'
    elsif c.ascii_lowercase?
      t = 'l'
    elsif c >= '0' && c <= '9'
      t = 'd'
    end
    ctypes[t] += 1
  end
  changes.push(reps)
  ctypes.delete('n')
  k = ctypes.keys.size
  if k < 3
    spare = ctypes.values.sum - k
    if spare < 0
      changes.push(-spare)
    end
  end
  if a.size < 6
    changes.push(6 - a.size)
  end
  changes.max
end

require "spec"
describe "strongpassword" do
  it "test_ex1" do
    strongpassword("a").should eq 5
  end
  it "test_ex2" do
    strongpassword("aB2").should eq 3
  end
  it "test_ex3" do
    strongpassword("PaaSW0rd").should eq 0
  end
  it "test_ex4" do
    strongpassword("Paaasw0rd").should eq 1
  end
  it "test_ex5" do
    strongpassword("aaaaa").should eq 3
  end
end
