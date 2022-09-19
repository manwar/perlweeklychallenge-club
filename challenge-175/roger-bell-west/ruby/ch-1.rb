#! /usr/bin/ruby

require 'test/unit'

require 'date'

def lastsunday(year0)
  year = year0
  o = []
  2.upto(13) do |month0|
    month = month0
    if month0 == 13 then
      year += 1
      month -= 12
    end
    dt = Date.new(year,month,1).prev_day
    dt = dt.prev_day(dt.wday)
    o.push(dt.strftime("%Y-%m-%d"))
  end
  return o
end


class TestLastSunday < Test::Unit::TestCase

  def test_ex1
    assert_equal([ '2022-01-30',
                   '2022-02-27',
                   '2022-03-27',
                   '2022-04-24',
                   '2022-05-29',
                   '2022-06-26',
                   '2022-07-31',
                   '2022-08-28',
                   '2022-09-25',
                   '2022-10-30',
                   '2022-11-27',
                   '2022-12-25' ],
                 lastsunday(2022))
  end

end
