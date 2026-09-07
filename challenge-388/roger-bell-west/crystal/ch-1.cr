#! /usr/bin/crystal

def dyckwords(order)
  out = Array(String).new
  queue = [""]
  while queue.size > 0
    st = queue.shift
    dcount = st.chars.select{|c| c == 'D'}.size
    if st.size == order * 2
      if dcount == order
        out.push(st)
      end
    else
      if dcount * 2 < st.size
        queue.push(st + 'D')
      end
        queue.push(st + 'U')
    end
  end
  out
end

require "spec"
describe "dyckwords" do
  it "test_ex1" do
    dyckwords(1).should eq ["UD"]
  end
  it "test_ex2" do
    dyckwords(2).should eq ["UDUD", "UUDD"]
  end
  it "test_ex3" do
    dyckwords(3).should eq ["UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD"]
  end
  it "test_ex4" do
    dyckwords(0).should eq [""]
  end
  it "test_ex5" do
    dyckwords(4).should eq ["UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD", "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD", "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD"]
  end
end
