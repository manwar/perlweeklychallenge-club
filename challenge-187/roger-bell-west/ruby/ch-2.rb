#! /usr/bin/ruby

require 'test/unit'

def magicaltriplets(a)
  out = []
  mv = 0
  a.combination(3) do |b|
        if b[0] + b[1] > b[2] &&
           b[1] + b[2] > b[0] &&
           b[0] + b[2] > b[1] then
          v = b[0] + b[1] + b[2]
          if v > mv then
            mv = v
            out = b
          end
    end
  end
  return out.sort.reverse
end

class TestMagicaltriplets < Test::Unit::TestCase

  def test_ex1
    assert_equal([3, 2, 2],
                 magicaltriplets([1, 2, 3, 2]))
  end

  def test_ex2
    assert_equal([],
                 magicaltriplets([1, 3, 2]))
  end

  def test_ex3
    assert_equal([],
                 magicaltriplets([1, 1, 2, 3]))
  end

  def test_ex4
    assert_equal([4, 3, 2],
                 magicaltriplets([2, 4, 3]))
  end

end
