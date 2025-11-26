#! /usr/bin/ruby

def counterify(a)
  cc = Hash.new
  cc.default = 0
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def meetingpoint(a)
  c = counterify(a.chars)
  c['U'] == c['D'] && c['L'] == c['R']
end

require 'test/unit'

class TestMeetingpoint < Test::Unit::TestCase

  def test_ex1
    assert_equal(false, meetingpoint('ULD'))
  end

  def test_ex2
    assert_equal(true, meetingpoint('ULDR'))
  end

  def test_ex3
    assert_equal(false, meetingpoint('UUURRRDDD'))
  end

  def test_ex4
    assert_equal(true, meetingpoint('UURRRDDLLL'))
  end

  def test_ex5
    assert_equal(false, meetingpoint('RRUULLDDRRUU'))
  end

end
