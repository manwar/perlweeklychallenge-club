#! /usr/bin/ruby

def cz(yy)
  y=yy
  if y<0 then
    y += 1
  end
  y = y % 60
  while y<0
    y += 60
  end
  return [['Metal','Water','Wood','Fire','Earth'][(y/2).floor%5],
          ['Monkey','Rooster','Dog','Pig','Rat','Water Buffalo','Tiger','Cat','Dragon','Snake','Horse','Goat'][y%12]].join(' ')
end

require 'test/unit'

class TestCz < Test::Unit::TestCase

  def test_ex1
    assert_equal('Fire Rooster',cz(2017))
  end

  def test_ex2
    assert_equal('Earth Tiger',cz(1938))
  end

end
