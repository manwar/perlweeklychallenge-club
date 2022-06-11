#! /usr/bin/ruby

require 'test/unit'

require 'set'
require 'prime'

def padovanprimes(ct)
  pp=Set.new
  padovans=[1,1,1]
  while true do
    padovans.push(padovans[0]+padovans[1])
    padovans.shift
    if padovans[-1].prime? then
      pp.add(padovans[-1])
      if pp.length >= ct then
        break
      end
    end
  end
  return pp.to_a.sort
end

class TestFactorion < Test::Unit::TestCase

  def test_ex1
    assert_equal([2,3,5,7,37,151,3329,23833,13091204281,3093215881333057],
                 padovanprimes(10))
  end

end
