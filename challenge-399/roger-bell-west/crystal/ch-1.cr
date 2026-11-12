#! /usr/bin/crystal

def lsub(wm, t)
  start = 0
  state = 0
  ll = Array(Int32).new
  0.upto(wm.size - 1) do |n|
    if state == 0
      if wm[n] == t
        start = n
        state = 1
      end
    else
      if wm[n] != t
        ll.push(n - start)
        state = 0
      end
    end
  end
  if state == 1
    ll.push(wm.size - start)
  end
  ll.max
end

def longestrepeatingcharacter(st, k)
  origin = st.chars
  targets = origin.to_set
  longestsub = 0
  targets.each do |t|
    queue = Deque(Tuple(Array(Char), Int32)).new
    queue.push({origin, 0})
    while queue.size > 0
      wm, ct = queue.shift
      longestsub = [longestsub, lsub(wm, t)].max
      if ct < k
        ctp = ct + 1
        0.upto(wm.size - 1) do |n|
          if wm[n] != t
            wmp = wm.clone
            wmp[n] = t
            queue.push({wmp, ctp})
          end
        end
      end
    end
  end
  longestsub
end

require "spec"
describe "longestrepeatingcharacter" do
  it "test_ex1" do
    longestrepeatingcharacter("AAAAA", 2).should eq 5
  end
  it "test_ex2" do
    longestrepeatingcharacter("ABCDE", 4).should eq 5
  end
  it "test_ex3" do
    longestrepeatingcharacter("AAABBBBAA", 1).should eq 5
  end
  it "test_ex4" do
    longestrepeatingcharacter("ABACADA", 2).should eq 5
  end
  it "test_ex5" do
    longestrepeatingcharacter("BAAABAAAA", 1).should eq 8
  end
end
