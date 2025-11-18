#! /usr/bin/ruby

def hm2m(a)
  p = a.split(":")
  return p[0].to_i * 60 + p[1].to_i
end

def converttime(ssrc, ttgt)
  src = hm2m(ssrc)
  tgt = hm2m(ttgt)
  if tgt < src
    tgt += 24 * 60
  end
  delta = tgt - src
  oc = 0
  [60, 15, 5, 1].each do |op|
    q, delta = delta.divmod(op)
    oc += q
  end
  oc
end

require 'test/unit'

class TestConverttime < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, converttime('02:30', '02:45'))
  end

  def test_ex2
    assert_equal(2, converttime('11:55', '12:15'))
  end

  def test_ex3
    assert_equal(4, converttime('09:00', '13:00'))
  end

  def test_ex4
    assert_equal(3, converttime('23:45', '00:30'))
  end

  def test_ex5
    assert_equal(2, converttime('14:20', '15:25'))
  end

end
