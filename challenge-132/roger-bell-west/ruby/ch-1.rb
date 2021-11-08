#! /usr/bin/ruby

require 'date'

def mirdat(thn,now)
  thnt=Date.new(*thn)
  if now[0]==0 then
    nowt=Date.now
  else
    nowt=Date.new(*now)
  end
  delta=nowt-thnt
  o=[]
  for targett in [thnt-delta,nowt+delta]
       o.push([targett.year,targett.month,targett.day])
  end
  return o
end

require 'test/unit'

class TestMirdat < Test::Unit::TestCase

  def test_ex1
    assert_equal(
      [[2021,9,14],[2021,9,26]],
      mirdat(
        [2021,9,18],[2021,9,22]
      )
    )
  end

  def test_ex2
    assert_equal(
      [[1929,10,27],[2067,9,5]],
      mirdat(
        [1975,10,10],[2021,9,22]
      )
    )
  end

  def test_ex3
    assert_equal(
      [[1912,7,8],[2076,4,30]],
      mirdat(
        [1967,2,14],[2021,9,22]
      )
    )
  end

end
