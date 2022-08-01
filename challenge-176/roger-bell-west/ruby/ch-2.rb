#! /usr/bin/ruby

require 'test/unit'

def reversible(mx)
  o = []
  1.upto(mx) do |n|
    t = n + n.to_s.reverse.to_i
    q = true
    while t > 0 do
      (t,d) = t.divmod(10)
      if d % 2 == 0 then
        q = false
        break
      end
    end
    if q then
      o.push(n)
    end
  end
  return o
end

class TestReversible < Test::Unit::TestCase

  def test_ex1
    assert_equal([ 10, 12, 14, 16, 18, 21, 23, 25, 27, 30, 32, 34, 36,
                   41, 43, 45, 50, 52, 54, 61, 63, 70, 72, 81, 90 ],
                 reversible(99))
  end

end
