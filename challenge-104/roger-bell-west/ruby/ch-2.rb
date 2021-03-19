#! /usr/bin/ruby

def game(hh=12)
  heap=hh
  players=%w{ Alice Bob }
  a=0
  while heap>0
    n=play(heap)
    heap -= n
    STDERR.puts("#{players[a]} takes #{n} leaving #{heap}")
    if heap==0 then
      STDERR.puts("#{players[a]} wins")
      break
    end
    a += 1
    a = a % 2
  end
  return a
end

def play(state)
  m=state % 4
  if m==0 then
    return 1+rand(3)
  else
    return m
  end
end

require 'test/unit'

class TestNim < Test::Unit::TestCase

  def test_ex1
    assert_equal(game(),1)
  end
  
  def test_ex2
    assert_equal(game(10),0)
  end
  
  def test_ex3
    assert_equal(game(14),0)
  end
  
end
