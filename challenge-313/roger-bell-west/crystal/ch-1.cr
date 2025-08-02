#! /usr/bin/crystal

def brokenkeys(name, typed)
  nt = name.chars()
  tt = typed.chars()
  ni = 0
  ti = 0
  while true
    if nt[ni] != tt[ti]
      return false
    end
    if ti == tt.size - 1
      break
    end
    if ni < nt.size - 1 && nt[ni + 1] == nt[ni]
      ni += 1
    else
      while ti < tt.size && tt[ti] == nt[ni]
        ti += 1
      end
      if ti == tt.size
        break
      end
      ni += 1
    end
  end
  true
end

require "spec"
describe "brokenkeys" do
  it "test_ex1" do
    brokenkeys("perl", "perrrl").should eq true
  end
  it "test_ex2" do
    brokenkeys("raku", "rrakuuuu").should eq true
  end
  it "test_ex3" do
    brokenkeys("python", "perl").should eq false
  end
  it "test_ex4" do
    brokenkeys("coffeescript", "cofffeescccript").should eq true
  end
end
