#! /usr/bin/ruby

def replacewords(ww, a)
  out = []
  a.split(' ').each do |w|
    r = false
    ww.each do |lw|
      if w.index(lw) == 0
        out.push(lw)
        r = true
        break
      end
    end
    if !r
      out.push(w)
    end
  end
  out.join(' ')
end

require 'test/unit'

class TestReplacewords < Test::Unit::TestCase

  def test_ex1
    assert_equal('the cat was rat by the bat', replacewords(['cat', 'bat', 'rat'], 'the cattle was rattle by the battery'))
  end

  def test_ex2
    assert_equal('a a a c b', replacewords(['a', 'b', 'c'], 'aab aac and cac bab'))
  end

  def test_ex3
    assert_equal('the man was hit by a bike', replacewords(['man', 'bike'], 'the manager was hit by a biker'))
  end

end
