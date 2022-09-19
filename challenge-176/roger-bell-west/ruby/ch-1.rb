#! /usr/bin/ruby

require 'test/unit'

def permutable
  n = 0
  while true do
    n += 1
    base = n.to_s.split('').sort
    q = true
    2.upto(6) do |k|
      if (n*k).to_s.split('').sort != base then
        q = false
        break
      end
    end
    if q then
      return n
    end
  end
end

class TestPermutable < Test::Unit::TestCase

  def test_ex1
    assert_equal(142857,
                 permutable())
  end

end
