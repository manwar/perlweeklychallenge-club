#! /usr/bin/ruby

require 'test/unit'

def factorion(input)
  if input==0 then
    return false
  end
  fd=[1]
  ff=1
  1.upto(10) do |i|
    ff *= i
    fd.push(ff)
  end
  working=input
  dsum=0
  while working>0 do
    working,d=working.divmod(10)
    dsum += fd[d]
  end
  return input==dsum
end

class TestFactorion < Test::Unit::TestCase

  def test_ex1
    assert_equal(true,factorion(145))
  end

  def test_ex2
    assert_equal(false,factorion(125))
  end

end
