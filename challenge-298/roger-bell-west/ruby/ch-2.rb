#! /usr/bin/ruby

def rightinterval(a)
  ss = a.map{|x| x[0]}
  si = (0 ... a.length).to_a.sort_by{|i| ss[i]}
  out = []
  a.each do |l|
    ix = si.filter{|i| ss[i] >= l[1]}
    if ix.length == 0
      out.push(-1)
    else
      out.push(ix[0])
    end
  end
  out
end

require 'test/unit'

class TestRightinterval < Test::Unit::TestCase

  def test_ex1
    assert_equal([-1, 0, 1], rightinterval([[3, 4], [2, 3], [1, 2]]))
  end

  def test_ex2
    assert_equal([-1, 2, -1], rightinterval([[1, 4], [2, 3], [3, 4]]))
  end

  def test_ex3
    assert_equal([-1], rightinterval([[1, 2]]))
  end

  def test_ex4
    assert_equal([-1, 1, -1], rightinterval([[1, 4], [2, 2], [3, 4]]))
  end

end
