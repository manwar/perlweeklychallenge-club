#! /usr/bin/ruby

require 'test/unit'

require 'set'
require 'prime'

def homeprime(n0)
  n = n0
  while true do
    tt = n.prime_division
    if tt.length == 1 && tt.collect{|i| i[1]}.max == 1 then
      break
    end
    ns = ''
    for d,td in tt do
      ds = d.to_s
      1.upto(td) do
        ns += ds
      end
    end
    n = ns.to_i
  end
  return n
end

class TestHomeprime < Test::Unit::TestCase

  def test_ex1
    assert_equal(773,homeprime(10))
  end

  def test_ex2
    assert_equal(31636373,homeprime(16))
  end

end
