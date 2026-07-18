#! /usr/bin/crystal

def replacequestionmark(a)
  template = a.chars.to_a
  q = template.select{|x| x == '?'}.size
  if q == 0
    return [a]
  end
  out = Array(String).new
  0.upto((1 << q)-1) do |n|
    qm = Array(Char).new
    nn = n
    while nn > 0
      qm.push(if nn % 2 == 1
              '1'
             else
               '0'
              end)
      nn //= 2
    end
    while qm.size < q
      qm.push('0')
    end
    entry = ""
    template.each do |tc|
      entry += (
        case tc
        when '?'
          qm.pop
        else
          tc
        end
      )
    end
    out.push(entry)
  end
  out
end

require "spec"
describe "replacequestionmark" do
  it "test_ex1" do
    replacequestionmark("01??0").should eq ["01000", "01010", "01100", "01110"]
  end
  it "test_ex2" do
    replacequestionmark("101").should eq ["101"]
  end
  it "test_ex3" do
    replacequestionmark("???").should eq ["000", "001", "010", "011", "100", "101", "110", "111"]
  end
  it "test_ex4" do
    replacequestionmark("1?10").should eq ["1010", "1110"]
  end
  it "test_ex5" do
    replacequestionmark("1?1?0").should eq ["10100", "10110", "11100", "11110"]
  end
end
