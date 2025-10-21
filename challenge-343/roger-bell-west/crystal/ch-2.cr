#! /usr/bin/crystal

def championteam(a)
  maxw = 0
  teamw = Array(Int32).new
  a.each_with_index do |w, i|
    wins = w.sum
    if wins > maxw
      teamw = Array(Int32).new
      maxw = wins
    end
    if wins == maxw
      teamw.push(i)
    end
  end
  if teamw.size == 1
    return teamw[0]
  end
  bestt = teamw[0]
  teamw.each do |rt|
    if a[rt][bestt] == 1
      bestt = rt
    end
  end
  bestt
end

def championteam(a)
  maxw = 0
  teamw = Array(Int32).new
  a.each_with_index do |w, i|
    wins = w.sum
    if wins > maxw
      teamw = Array(Int32).new
      maxw = wins
    end
    if wins == maxw
      teamw.push(i)
    end
  end
  if teamw.size == 1
    return teamw[0]
  end
  bestt = teamw[0]
  teamw.each do |rt|
    if a[rt][bestt] == 1
      bestt = rt
    end
  end
  bestt
end
require "spec"
describe "championteam" do
  it "test_ex1" do
    championteam([[0, 1, 1], [0, 0, 1], [0, 0, 0]]).should eq 0
  end
  it "test_ex2" do
    championteam([[0, 1, 0, 0], [0, 0, 0, 0], [1, 1, 0, 0], [1, 1, 1, 0]]).should eq 3
  end
  it "test_ex3" do
    championteam([[0, 1, 0, 1], [0, 0, 1, 1], [1, 0, 0, 0], [0, 0, 1, 0]]).should eq 0
  end
  it "test_ex4" do
    championteam([[0, 1, 1], [0, 0, 0], [0, 1, 0]]).should eq 0
  end
  it "test_ex5" do
    championteam([[0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 1, 0, 1, 1], [1, 1, 0, 0, 0], [1, 1, 0, 1, 0]]).should eq 2
  end
end
