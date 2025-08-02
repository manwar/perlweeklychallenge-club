#! /usr/bin/ruby

def reverseword(a, c)
  mm = a.index(c)
  if mm.nil?
    return a
  end
  b = a[0, mm + 1].split("")
  b.sort!()
  b.concat(a[mm + 1, a.size - mm].split("") )
  b.join("")
end

require 'test/unit'

class TestReverseword < Test::Unit::TestCase

  def test_ex1
    assert_equal('acehllnge', reverseword('challenge', 'e'))
  end

  def test_ex2
    assert_equal('agoprrmming', reverseword('programming', 'a'))
  end

  def test_ex3
    assert_equal('champion', reverseword('champion', 'b'))
  end

end
