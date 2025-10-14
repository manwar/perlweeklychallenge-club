#! /usr/bin/ruby

def championteam(a)
  maxw = 0
  teamw = []
  a.each_with_index do |w, i|
    wins = w.sum
    if wins > maxw
      teamw = []
      maxw = wins
    end
    if wins == maxw
      teamw.push(i)
    end
  end
  if teamw.length == 1
    return teamw[0]
  end
  bestt = teamw[0]
  teamw.each do |rt|
    if a[rt][bestt] == 1
      bestt = rt
    end
  end
  bestt
end

require 'test/unit'

class TestChampionteam < Test::Unit::TestCase

  def test_ex1
    assert_equal(0, championteam([[0, 1, 1], [0, 0, 1], [0, 0, 0]]))
  end

  def test_ex2
    assert_equal(3, championteam([[0, 1, 0, 0], [0, 0, 0, 0], [1, 1, 0, 0], [1, 1, 1, 0]]))
  end

  def test_ex3
    assert_equal(0, championteam([[0, 1, 0, 1], [0, 0, 1, 1], [1, 0, 0, 0], [0, 0, 1, 0]]))
  end

  def test_ex4
    assert_equal(0, championteam([[0, 1, 1], [0, 0, 0], [0, 1, 0]]))
  end

  def test_ex5
    assert_equal(2, championteam([[0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 1, 0, 1, 1], [1, 1, 0, 0, 0], [1, 1, 0, 1, 0]]))
  end

end
