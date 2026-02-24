#! /usr/bin/crystal

def spellboundsorting(a)
  o = a
  o.sort_by! { |x| towords(x) }
  o
end

def towords(a)
  if a == 0
    return "zero"
  end
  components = Array(String).new
  b = a
  if a < 0
    b = -a
    components.push("minus")
  end
  vw = [
    [1000000000, "milliard"],
    [1000000, "million"],
    [1000, "thousand"],
    [100, "hundred"],
    [90, "ninety"],
    [80, "eighty"],
    [70, "seventy"],
    [60, "sixty"],
    [50, "fifty"],
    [40, "forty"],
    [30, "thirty"],
    [20, "twenty"],
    [19, "nineteen"],
    [18, "eighteen"],
    [17, "seventeen"],
    [16, "sixteen"],
    [15, "fifteen"],
    [14, "fourteen"],
    [13, "thirteen"],
    [12, "twelve"],
    [11, "eleven"],
    [10, "ten"],
    [9, "nine"],
    [8, "eight"],
    [7, "seven"],
    [6, "six"],
    [5, "five"],
    [4, "four"],
    [3, "three"],
    [2, "two"],
    [1, "one"],
  ]
  cw(b, vw).each do |w|
    components.push(w)
  end
  components.join(" ")
end

def cw(n, vw)
  res = Array(String).new
  vw.each do |(xval, xword)|
    val = xval.to_i
    word = xword.to_s
    if n >= val
      andflag = false
      if n >= 100
        andflag = true
        cw(n / val, vw).each do |w|
          res.push(w)
        end
      end
      res.push(word)
      p = n % val
      if p > 0
        if andflag
          res.push("and")
        end
        cw(p, vw).each do |w|
          res.push(w)
        end
      end
      break
    end
  end
  res
end

require "spec"
describe "spellboundsorting" do
  it "test_ex1" do
    spellboundsorting([6, 7, 8, 9, 10]).should eq [8, 9, 7, 6, 10]
  end
  it "test_ex2" do
    spellboundsorting([-3, 0, 1000, 99]).should eq [-3, 99, 1000, 0]
  end
  it "test_ex3" do
    spellboundsorting([1, 2, 3, 4, 5]).should eq [5, 4, 1, 3, 2]
  end
  it "test_ex4" do
    spellboundsorting([0, -1, -2, -3, -4]).should eq [-4, -1, -3, -2, 0]
  end
  it "test_ex5" do
    spellboundsorting([100, 101, 102]).should eq [100, 101, 102]
  end
end
