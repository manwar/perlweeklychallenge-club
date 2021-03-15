#! /usr/bin/ruby

def pm(text,match)
  re='^' + match + '$'
  re=re.gsub(/\?/,'.')
  re=re.gsub(/\*/,'.*')
  if text =~ Regexp.new(re) then
    return 1
  end
  return 0
end

require 'test/unit'

class TestPm < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,pm('abcde','a*e'))
  end

  def test_ex2
    assert_equal(0,pm('abcde','a*d'))
  end

  def test_ex3
    assert_equal(0,pm('abcde','?b*d'))
  end

  def test_ex4
    assert_equal(1,pm('abcde','a*c?e'))
  end

end
