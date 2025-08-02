#! /usr/bin/ruby

def finalprice(a)
  out = []
  a.each_with_index do |n, i|
    discount = 0
    (i + 1).upto(a.length - 1) do |mi|
      if a[mi] <= n
        discount = a[mi]
        break
      end
    end
    out.push(n - discount)
  end
  out
end

require 'test/unit'

class TestFinalprice < Test::Unit::TestCase

  def test_ex1
    assert_equal([4, 2, 4, 2, 3], finalprice([8, 4, 6, 2, 3]))
  end

  def test_ex2
    assert_equal([1, 2, 3, 4, 5], finalprice([1, 2, 3, 4, 5]))
  end

  def test_ex3
    assert_equal([6, 0, 1, 5], finalprice([7, 1, 1, 5]))
  end

end
