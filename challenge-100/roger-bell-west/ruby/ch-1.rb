#! /usr/bin/ruby

def ft(inp)
  md=/(\d+):(\d+)\s*([ap]m)?/.match(inp)
  h=md[1].to_i
  t=""
  if md[3] then
    if h==12 then
      h=0
    end
    if md[3] == "pm" then
      h += 12
    end
  else
    t=" am"
    if h > 11 then
      t=" pm"
      h -= 12
    end
    if h==0 then
      h=12
    end
  end
  return sprintf('%02d:%02d%s',h,md[2],t)
end

require 'test/unit'

class TestFt < Test::Unit::TestCase

  def test_ex1
    assert_equal('17:15',ft('05:15 pm'))
  end

  def test_ex2
    assert_equal('17:15',ft('05:15 pm'))
  end

  def test_ex3
    assert_equal('07:15 pm',ft('19:15'))
  end

  def test_ex4
    assert_equal('12:00 am',ft('00:00'))
  end

  def test_ex5
    assert_equal('12:00 pm',ft('12:00'))
  end

  def test_ex6
    assert_equal('00:00',ft('12:00 am'))
  end

  def test_ex7
    assert_equal('12:00',ft('12:00 pm'))
  end

end
