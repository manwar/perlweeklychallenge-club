#! /usr/bin/ruby

def makeitbigger(st, ch)
  cx = ch.chars[0]
  nn = []
  0.upto(st.size - 1) do |i|
    if st[i] == cx
      o = st[0, i]
      if i < st.size - 1
        o += st[i + 1 .. -1]
      end
      nn.push(o.to_i)
    end
  end
  nn.max.to_s
end

require 'test/unit'

class TestMakeitbigger < Test::Unit::TestCase

  def test_ex1
    assert_equal('1546', makeitbigger('15456', '5'))
  end

  def test_ex2
    assert_equal('732', makeitbigger('7332', '3'))
  end

  def test_ex3
    assert_equal('231', makeitbigger('2231', '2'))
  end

  def test_ex4
    assert_equal('54321', makeitbigger('543251', '5'))
  end

  def test_ex5
    assert_equal('921', makeitbigger('1921', '1'))
  end

end
