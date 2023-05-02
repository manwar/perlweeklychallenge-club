#! /usr/bin/ruby

require 'test/unit'

def rankscore(a)
  av = Hash.new
  a.each do |s|
    if av.has_key?(s) then
      av[s] += 1
    else
      av[s] = 1
    end
  end
  rank = 1
  tab = Hash.new
  av.keys.sort.reverse.each do |k|
    siz = av[k]
    r = ""
    if rank <= 3 then
      r = ["G", "S", "B"][rank - 1]
    else
      r = rank.to_s
    end
    if siz > 1 then
      r += "="
    end
    tab[k] = r
    rank += siz
  end
  return a.map{|i| tab[i]}
end

class TestRankscore < Test::Unit::TestCase

  def test_ex1
    assert_equal(['5', '4', 'S', 'B', 'G'], rankscore([1, 2, 4, 3, 5]))
  end

  def test_ex2
    assert_equal(['G', '4', 'B', 'S', '5'], rankscore([8, 5, 6, 7, 4]))
  end

  def test_ex3
    assert_equal(['B', 'G', 'S', '4'], rankscore([3, 5, 4, 2]))
  end

  def test_ex4
    assert_equal(['4=', 'S=', '4=', '6=', 'G', 'S=', '6='], rankscore([2, 5, 2, 1, 7, 5, 1]))
  end

end
