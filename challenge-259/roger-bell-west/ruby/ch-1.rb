#! /usr/bin/ruby

require 'set'
require 'time'

def parsedate(s)
  return Time.strptime(s + " 12:00 +0000", '%Y-%m-%d %H:%M %z')
end

def bankingdayoffset(start, offset, bankholidays)
  bh = Set.new(bankholidays.map {|d| parsedate(d)})
  s = parsedate(start)
  1.upto(offset) do
    s += 86400
    while bh.include?(s) || s.wday == 0 || s.wday == 6 do
    s += 86400
    end
  end
  return s.strftime('%Y-%m-%d')
end

require 'test/unit'

class TestBankingdayoffset < Test::Unit::TestCase

  def test_ex1
    assert_equal('2018-07-04', bankingdayoffset('2018-06-28', 3, ['2018-07-03']))
  end

  def test_ex2
    assert_equal('2018-07-03', bankingdayoffset('2018-06-28', 3, []))
  end

end
