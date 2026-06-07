#! /usr/bin/crystal

def cs2xy(a)
  c = a.chars
  x = c[0].ord - 'a'.ord
  y = c[1].ord - '1'.ord
  [x, y]
end

def checkcolor(a)
  xy = cs2xy(a)
  (xy[0] + xy[1]) % 2 == 1
end

def chessboardsquares(a, b)
  checkcolor(a) == checkcolor(b)
end

require "spec"
describe "chessboardsquares" do
  it "test_ex1" do
    chessboardsquares("a7", "f4").should eq true
  end
  it "test_ex2" do
    chessboardsquares("c1", "e8").should eq false
  end
  it "test_ex3" do
    chessboardsquares("b5", "h2").should eq false
  end
  it "test_ex4" do
    chessboardsquares("f3", "h1").should eq true
  end
  it "test_ex5" do
    chessboardsquares("a1", "g8").should eq false
  end
end
