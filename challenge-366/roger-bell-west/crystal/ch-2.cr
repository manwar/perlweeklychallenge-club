#! /usr/bin/crystal

def validtimes(a)
  combinator = Array(Array(Int32)).new
  a.chars.each_with_index do |c, i|
    if c.ascii_number?(10)
      combinator.push([c.to_i])
    else
      case i
      when 0
        combinator.push((0 .. 2).to_a)
      when 1, 4
        combinator.push((0 .. 9).to_a)
      when 3
        combinator.push((0 .. 5).to_a)
      end
    end
  end
  if combinator.size != 4
    return 0
  end
  minutes = combinator[2].size * combinator[3].size
  ct = 0
  combinator[0].each do |ax|
    combinator[1].each do |bx|
      if ax * 10 + bx <= 23
        ct += 1
      end
    end
  end
  ct * minutes
end

require "spec"
describe "validtimes" do
  it "test_ex1" do
    validtimes("?2:34").should eq 3
  end
  it "test_ex2" do
    validtimes("?4:?0").should eq 12
  end
  it "test_ex3" do
    validtimes("??:??").should eq 1440
  end
  it "test_ex4" do
    validtimes("?3:45").should eq 3
  end
  it "test_ex5" do
    validtimes("2?:15").should eq 4
  end
end
