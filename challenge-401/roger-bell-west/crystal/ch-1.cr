#! /usr/bin/crystal

require "big"

def fractionaladditionsubstraction(a)
  terms = Array(BigRational).new
  state = 0
  n = 0
  num = 0
  sign = 0
  cv = a.chars
  i = 0
  while i < cv.size
    case state
    when 0
      case cv[i]
      when '+'
        state = 0
        i += 1
      when '0' .. '9'
        sign = 1
        state = 1
        n = cv[i].to_i
        i += 1
      when '-'
        sign = -1
        state = 1
        n = 0
        i += 1
      end
    when 1
      case cv[i]
      when '0' .. '9'
        n = n * 10 + cv[i].to_i
        i += 1
      when '/'
        num = n * sign
        n = 0
        state = 2
        i += 1
      end
    when 2
      case cv[i]
      when '0' .. '9'
        n = n * 10 + cv[i].to_i
        i += 1
      else
        terms.push(BigRational.new(num, n))
        state = 0
      end
    end
  end
  if state == 2
    terms.push(BigRational.new(num, n))
  end
  out = terms[0]
  terms.skip(1).each do |nt|
    out = out + nt
  end
  out.numerator.to_s + "/" + out.denominator.to_s
end

require "spec"
describe "fractionaladditionsubstraction" do
  it "test_ex1" do
    fractionaladditionsubstraction("1/2+3/2").should eq "2/1"
  end
  it "test_ex2" do
    fractionaladditionsubstraction("-5/2-3/2").should eq "-4/1"
  end
  it "test_ex3" do
    fractionaladditionsubstraction("5/3-5/3").should eq "0/1"
  end
  it "test_ex4" do
    fractionaladditionsubstraction("10/10-1/10+2/5").should eq "13/10"
  end
  it "test_ex5" do
    fractionaladditionsubstraction("1/6+1/6+1/6").should eq "1/2"
  end
end
