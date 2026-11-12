#! /usr/bin/ruby

require 'set'

def lsub(wm, t)
  start = 0
  state = 0
  ll = []
  0.upto(wm.size - 1) do |n|
    if state == 0
      if wm[n] == t
        start = n
        state = 1
      end
    else
      if wm[n] != t
        ll.push(n - start)
        state = 0
      end
    end
  end
  if state == 1
    ll.push(wm.size - start)
  end
  ll.max
end

def longestrepeatingcharacter(st, k)
  origin = st.chars
  targets = origin.to_set
  longestsub = 0
  targets.each do |t|
    queue = []
    queue.push([origin, 0])
    while queue.size > 0
      wm, ct = queue.shift
      longestsub = [longestsub, lsub(wm, t)].max
      if ct < k
        ctp = ct + 1
        0.upto(wm.size - 1) do |n|
          if wm[n] != t
            wmp = wm.clone
            wmp[n] = t
            queue.push([wmp, ctp])
          end
        end
      end
    end
  end
  longestsub
end

require 'test/unit'

class TestLongestrepeatingcharacter < Test::Unit::TestCase

  def test_ex1
    assert_equal(5, longestrepeatingcharacter('AAAAA', 2))
  end

  def test_ex2
    assert_equal(5, longestrepeatingcharacter('ABCDE', 4))
  end

  def test_ex3
    assert_equal(5, longestrepeatingcharacter('AAABBBBAA', 1))
  end

  def test_ex4
    assert_equal(5, longestrepeatingcharacter('ABACADA', 2))
  end

  def test_ex5
    assert_equal(8, longestrepeatingcharacter('BAAABAAAA', 1))
  end

end
