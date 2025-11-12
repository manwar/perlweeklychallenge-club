#! /usr/bin/ruby

def formatdate(a)
  a =~ /^([0-9]+)[a-z]+ ([A-Z][a-z]{2}) ([0-9]+)/;
  y = $3
  d = $1
  m = {
        "Jan" => 1,
        "Feb" => 2,
        "Mar" => 3,
        "Apr" => 4,
        "May" => 5,
        "Jun" => 6,
        "Jul" => 7,
        "Aug" => 8,
        "Sep" => 9,
        "Oct" => 10,
        "Nov" => 11,
        "Dec" => 12,
  }[$2]
  sprintf("%04d-%02d-%02d", y, m, d)
end

require 'test/unit'

class TestFormatdate < Test::Unit::TestCase

  def test_ex1
    assert_equal('2025-01-01', formatdate('1st Jan 2025'))
  end

  def test_ex2
    assert_equal('2025-02-22', formatdate('22nd Feb 2025'))
  end

  def test_ex3
    assert_equal('2025-04-15', formatdate('15th Apr 2025'))
  end

  def test_ex4
    assert_equal('2025-10-23', formatdate('23rd Oct 2025'))
  end

  def test_ex5
    assert_equal('2025-12-31', formatdate('31st Dec 2025'))
  end

end
