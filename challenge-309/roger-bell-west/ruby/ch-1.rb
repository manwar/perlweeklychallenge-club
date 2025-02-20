#! /usr/bin/ruby

def mingap(a)
  mg = a[-1] - a[0]
  mv = 0
  a.each_cons(2) do |p|
    delta = p[1] - p[0]
    if delta < mg
      mg = delta
      mv = p[1]
    end
  end
  mv
end

require 'test/unit'

class TestMingap < Test::Unit::TestCase

  def test_ex1
    assert_equal(11, mingap([2, 8, 10, 11, 15]))
  end

  def test_ex2
    assert_equal(6, mingap([1, 5, 6, 7, 14]))
  end

  def test_ex3
    assert_equal(28, mingap([8, 20, 25, 28]))
  end

end
