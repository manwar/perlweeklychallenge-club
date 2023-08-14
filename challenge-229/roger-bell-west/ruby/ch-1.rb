#! /usr/bin/ruby

def lexicographic(a)
  t = 0
  a.each do |st|
    q = st.split('').sort
    if q.join('') == st then
      next
    end
    q = q.reverse
    if q.join('') == st then
      next
    end
    t += 1
  end
  return t
end

require 'test/unit'

class TestLexicographic < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, lexicographic(['abc', 'bce', 'cae']))
  end

  def test_ex2
    assert_equal(2, lexicographic(['yxz', 'cba', 'mon']))
  end

end
