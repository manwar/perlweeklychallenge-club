#! /usr/bin/ruby

def nroot(n,a)
  xk=2.0
  while 1 do
    xk1=((n-1)*xk+a/(xk ** (n-1)))/n
    if xk1==xk then
      break
    end
    xk=xk1
  end
  return xk
end

require 'test/unit'

class TestNroot < Test::Unit::TestCase

  def test_ex1
    assert_equal(12,nroot(5,248832))
  end

  def test_ex2
    assert_equal(34**0.2,nroot(5,34))
  end

end
