#! /usr/bin/ruby

def matchstring(a)
  out = []
  a.each do |x|
    if !out.any? {|i| x == i}
      a.each do |y|
        if y.size > x.size && y.index(x)
          out.push(x)
          break
        end
      end
    end
  end
  out
end

require 'test/unit'

class TestMatchstring < Test::Unit::TestCase

  def test_ex1
    assert_equal(['cat', 'dog', 'dogcat', 'rat'], matchstring(['cat', 'cats', 'dog', 'dogcat', 'dogcat', 'rat', 'ratcatdogcat']))
  end

  def test_ex2
    assert_equal(['hell', 'world', 'wor', 'ellow'], matchstring(['hello', 'hell', 'world', 'wor', 'ellow', 'elloworld']))
  end

  def test_ex3
    assert_equal(['a', 'aa', 'aaa'], matchstring(['a', 'aa', 'aaa', 'aaaa']))
  end

  def test_ex4
    assert_equal(['flow', 'fl', 'fli', 'ig', 'ght'], matchstring(['flower', 'flow', 'flight', 'fl', 'fli', 'ig', 'ght']))
  end

  def test_ex5
    assert_equal(['car', 'pet', 'enter', 'pen', 'pent'], matchstring(['car', 'carpet', 'carpenter', 'pet', 'enter', 'pen', 'pent']))
  end

end
