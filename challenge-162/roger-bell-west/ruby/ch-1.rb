#! /usr/bin/ruby

require 'test/unit'

def generate(in0)
  in1 = in0.gsub(/[^0-9]+/,'')
  if in1.length < 12 then
    return 99
  end
  s = 0
  m = 1
  in1.split("").first(12).each do |i|
    s += i.to_i * m
    m = 4 - m
  end
  return (10-(s % 10)) % 10
end

def validate(in0)
  in1 = in0.gsub(/[^0-9]+/,'')
  if in1.length != 13 then
    return false
  end
  return generate(in1) == in1[-1].to_i
end

class TestIsbn < Test::Unit::TestCase

  def test_ex1
    assert_equal(7,
                 generate("978-0-306-40615-"))
  end

  def test_ex2
    assert_equal(7,
                 generate("978-0-306-40615-7"))
  end

  def test_ex3
    assert_equal(true,
                 validate("978-0-306-40615-7"))
  end

  def test_ex4
    assert_equal(false,
                 validate("978-0-306-46015-7"))
  end

end
