#! /usr/bin/ruby

def validtimes(a)
  combinator = []
  r = Regexp.new("[0-9]")
  a.chars.each_with_index do |c, i|
    if r =~ c
      combinator.push([c.to_i])
    else
      case i
      when 0
        combinator.push((0 .. 2).to_a)
      when 1, 4
        combinator.push((0 .. 9).to_a)
      when 3
        combinator.push((0 .. 5).to_a)
      end
    end
  end
  if combinator.size != 4
    return 0
  end
  minutes = combinator[2].size * combinator[3].size
  ct = 0
  combinator[0].each do |ax|
    combinator[1].each do |bx|
      if ax * 10 + bx <= 23
        ct += 1
      end
    end
  end
  ct * minutes
end

require 'test/unit'

class TestValidtimes < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, validtimes('?2:34'))
  end

  def test_ex2
    assert_equal(12, validtimes('?4:?0'))
  end

  def test_ex3
    assert_equal(1440, validtimes('??:??'))
  end

  def test_ex4
    assert_equal(3, validtimes('?3:45'))
  end

  def test_ex5
    assert_equal(4, validtimes('2?:15'))
  end

end
