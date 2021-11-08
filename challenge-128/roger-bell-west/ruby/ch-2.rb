#! /usr/bin/ruby

require 'test/unit'

def mp(aa,da)
  e=Hash.new(0)
  for p in [[aa,1],[da,-1]]
    for tm in p[0]
      hm=tm.split(":")
      e[(hm[0].to_i)*60+hm[1].to_i] += p[1]
    end
  end
  pt=0
  pm=0
  for ts in e.sort_by {|k, v| k.to_i}
    pt+=ts[1]
    if pt > pm then
      pm=pt
    end
  end
  return pm
end

class TestMp < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,mp(["11:20","14:30"],["11:50","15:00"]))
  end

  def test_ex2
    assert_equal(3,mp(["10:20","11:00","11:10","12:20","16:20","19:00"],["10:30","13:20","12:40","12:50","20:20","21:20"]))
  end
  
end
