#! /usr/bin/ruby

def specialnumbers(a)
  t = 0
  a.each_with_index do |n, i|
    if a.length % (i + 1) == 0 then
      t += n * n
    end
  end
  return t
end

require 'test/unit'

class TestSpecialnumbers < Test::Unit::TestCase

  def test_ex1
    assert_equal(21, specialnumbers([1, 2, 3, 4]))
  end

  def test_ex2
    assert_equal(63, specialnumbers([2, 7, 1, 19, 18, 3]))
  end

end
