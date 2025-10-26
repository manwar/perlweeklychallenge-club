#! /usr/bin/ruby

require 'set'

def arrayformation(src, tgt)
  stack = []
  stack.push([[], 0.upto(src.length - 1).to_set])
  while stack.length > 0
    c = stack.pop
    if c[0].length == tgt.length()
      return true
    else
      c[1].each do |candidate|
        offset = c[0].length
        nextcandidate = c[1].clone
        nextcandidate.delete(candidate)
        valid = true
        seq = c[0].clone
        src[candidate].each_with_index do |x, i|
          if x == tgt[i + offset]
            seq.push(x)
          else
            valid = false
            break
          end
        end
        if valid
          stack.push([seq, nextcandidate])
        end
      end
    end
  end
  false
end

require 'test/unit'

class TestArrayformation < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, arrayformation([[2, 3], [1], [4]], [1, 2, 3, 4]))
  end

  def test_ex2
    assert_equal(false, arrayformation([[1, 3], [2, 4]], [1, 2, 3, 4]))
  end

  def test_ex3
    assert_equal(true, arrayformation([[9, 1], [5, 8], [2]], [5, 8, 2, 9, 1]))
  end

  def test_ex4
    assert_equal(false, arrayformation([[1], [3]], [1, 2, 3]))
  end

  def test_ex5
    assert_equal(true, arrayformation([[7, 4, 6]], [7, 4, 6]))
  end

end
