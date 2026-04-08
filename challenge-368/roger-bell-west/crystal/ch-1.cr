#! /usr/bin/crystal

def makeitbigger(st, ch)
  cx = ch.chars[0]
  nn = Array(Int32).new
  0.upto(st.size - 1) do |i|
    if st[i] == cx
      o = st[0, i]
      if i < st.size - 1
        o += st[i + 1 .. -1]
      end
      nn.push(o.to_i)
    end
  end
  nn.max.to_s
end

require "spec"
describe "makeitbigger" do
  it "test_ex1" do
    makeitbigger("15456", "5").should eq "1546"
  end
  it "test_ex2" do
    makeitbigger("7332", "3").should eq "732"
  end
  it "test_ex3" do
    makeitbigger("2231", "2").should eq "231"
  end
  it "test_ex4" do
    makeitbigger("543251", "5").should eq "54321"
  end
  it "test_ex5" do
    makeitbigger("1921", "1").should eq "921"
  end
end
