#! /usr/bin/crystal

def formatphonenumber(a)
  pure = a.chars.select{|x| x >= '0' && x <= '9'}
    left = pure.size
    out = Array(Char).new
    i = 0
    if left > 4
        pure.each do |c|
            out.push(c)
            i += 1
            left -= 1
            if i % 3 == 0
                out.push('-')
                if left <= 4
                    break
                end
            end
        end
    end
    if left == 4
        out.push(pure[i])
        out.push(pure[i + 1])
        out.push('-')
        i += 2
    end
    i.upto(pure.size - 1) do |p|
        out.push(pure[p])
    end
    out.join("")
end

require "spec"
describe "formatphonenumber" do
  it "test_ex1" do
    formatphonenumber("1-23-45-6").should eq "123-456"
  end
  it "test_ex2" do
    formatphonenumber("1234").should eq "12-34"
  end
  it "test_ex3" do
    formatphonenumber("12 345-6789").should eq "123-456-789"
  end
  it "test_ex4" do
    formatphonenumber("123 4567").should eq "123-45-67"
  end
  it "test_ex5" do
    formatphonenumber("123 456-78").should eq "123-456-78"
  end
end
