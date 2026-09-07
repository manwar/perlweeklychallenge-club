#! /usr/bin/ruby

def dyckwords(order)
  out = []
  queue = [""]
  while queue.length > 0 do
    st = queue.shift
    dcount = st.chars.select{|c| c == 'D'}.length
    if st.size == order * 2
      if dcount == order
        out.push(st)
      end
    else
      if dcount * 2 < st.length
        queue.push(st + 'D')
      end
        queue.push(st + 'U')
    end
  end
  out
end

require 'test/unit'

class TestDyckwords < Test::Unit::TestCase

  def test_ex1
    assert_equal(['UD'], dyckwords(1))
  end

  def test_ex2
    assert_equal(['UDUD', 'UUDD'], dyckwords(2))
  end

  def test_ex3
    assert_equal(['UDUDUD', 'UDUUDD', 'UUDDUD', 'UUDUDD', 'UUUDDD'], dyckwords(3))
  end

  def test_ex4
    assert_equal([''], dyckwords(0))
  end

  def test_ex5
    assert_equal(['UDUDUDUD', 'UDUDUUDD', 'UDUUDDUD', 'UDUUDUDD', 'UDUUUDDD', 'UUDDUDUD', 'UUDDUUDD', 'UUDUDDUD', 'UUDUDUDD', 'UUDUUDDD', 'UUUDDDUD', 'UUUDDUDD', 'UUUDUDDD', 'UUUUDDDD'], dyckwords(4))
  end

end
