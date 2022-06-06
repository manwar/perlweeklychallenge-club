#! /usr/bin/ruby

require 'test/unit'

require 'prime'
require 'set'

def perrinprime(n)
  out = Set.new
  seq = [3, 0, 2]
  while true do
    seq.push(seq[0] + seq[1])
    seq.shift
    if seq[-1].prime? then
      out.add(seq[-1])
      if out.length >= n then
        break
      end
    end
  end
  return out.to_a.sort
end

class TestPerrinprime < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721,
                  1442968193, 792606555396977],
                 perrinprime(13))
  end

end
