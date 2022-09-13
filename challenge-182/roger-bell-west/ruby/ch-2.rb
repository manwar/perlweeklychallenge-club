#! /usr/bin/ruby

require 'test/unit'

def commonpath(p)
  pa = []
  pl = []
  p.each do |sp|
    q = sp.split("/")
    pl.push(q.length)
    pa.push(q)
  end
  out = []
  0.upto(pl.min-1).each do |cl|
    ex = false
    tx = pa[0][cl]
    pa.each do |pe|
      if pe[cl] != tx then
        ex = true
        break
      end
    end
    if ex then
      break
    end
    out.push(tx)
  end
  return out.join("/")
end

class TestCommonpath < Test::Unit::TestCase

  def test_ex1
    assert_equal("/a/b/c", commonpath([
                                        "/a/b/c/1/x.pl",
                                        "/a/b/c/d/e/2/x.pl",
                                        "/a/b/c/d/3/x.pl",
                                        "/a/b/c/4/x.pl",
                                        "/a/b/c/d/5/x.pl"
                                      ]))
  end

end
