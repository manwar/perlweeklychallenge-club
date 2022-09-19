#! /usr/bin/ruby

require 'test/unit'

require 'time'

def addbizhours(start, delta)
  current = Time.strptime(start + " +0000", '%Y-%m-%d %H:%M %z')
  seconds = 3600 * delta
  bizdaylength = 3600 * 9
  if !isbiz(current) then
    current = nextbizstart(current)
  end
  ed = nextbizend(current)
  remain = ed - current
  if remain < seconds then
    seconds -= remain
    current = nextbizstart(ed)
    while seconds > bizdaylength do
      current = nextbizstart(current)
      seconds -= bizdaylength
    end
  end
  current += seconds
  return current.strftime('%Y-%m-%d %H:%M')
end

def sethour(tm,hour)
  ar = tm.to_a
  ar[2] = hour
  return Time.utc(*ar)
end

def isbiz(tm)
  if tm.wday == 0 || tm.wday == 6 then
    return false
  end
  if tm.hour < 9 || tm.hour >= 18 then
    return false
  end
  return true
end

def nextbizstart(tm0)
  tm = tm0
  while tm.wday == 0 || tm.wday == 6 do
    tm += 86400
    tm = sethour(tm, 9)
  end
  if tm.hour < 9 then
    tm = sethour(tm, 9)
  else
    while true do
      tm += 86400
      tm = sethour(tm, 9)
      if tm.wday > 0 && tm.wday < 6 then
        break
      end
    end
  end
  return tm
end

def nextbizend(tm0)
  tm = tm0
  while tm.wday == 0 || tm.wday == 6 do
    tm += 86400
    tm = sethour(tm, 18)
  end
  if tm.hour >= 18 then
    while true do
      tm += 86400
      tm = sethour(tm, 18)
      if tm.wday > 0 && tm.wday < 6 then
        break
      end
    end
  else
    tm = sethour(tm, 18)
  end
  return tm
end

class TestReversible < Test::Unit::TestCase

  def test_ex1
    assert_equal("2022-08-01 14:30", addbizhours("2022-08-01 10:30", 4.0))
  end

  def test_ex2
    assert_equal("2022-08-02 11:30", addbizhours("2022-08-01 17:00", 3.5))
  end

  def test_ex3
    assert_equal("2022-08-02 12:30", addbizhours("2022-08-01 18:00", 3.5))
  end

  def test_ex4
    assert_equal("2022-08-02 12:30", addbizhours("2022-08-01 19:00", 3.5))
  end

  def test_ex5
    assert_equal("2022-08-08 11:30", addbizhours("2022-08-05 17:00", 3.5))
  end

  def test_ex6
    assert_equal("2022-08-03 12:00", addbizhours("2022-08-01 12:00",18.0))
  end

end
