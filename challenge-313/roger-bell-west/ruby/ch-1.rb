#! /usr/bin/ruby

def brokenkeys(name, typed)
  nt = name.chars()
  tt = typed.chars()
  ni = 0
  ti = 0
  while true
    if nt[ni] != tt[ti]
      return false
    end
    if ti == tt.size - 1
      break
    end
    if ni < nt.size - 1 && nt[ni + 1] == nt[ni]
      ni += 1
    else
      while ti < tt.size && tt[ti] == nt[ni]
        ti += 1
      end
      if ti == tt.size
        break
      end
      ni += 1
    end
  end
  true
end

require 'test/unit'

class TestBrokenkeys < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, brokenkeys('perl', 'perrrl'))
  end

  def test_ex2
    assert_equal(true, brokenkeys('raku', 'rrakuuuu'))
  end

  def test_ex3
    assert_equal(false, brokenkeys('python', 'perl'))
  end

  def test_ex4
    assert_equal(true, brokenkeys('coffeescript', 'cofffeescccript'))
  end

end
