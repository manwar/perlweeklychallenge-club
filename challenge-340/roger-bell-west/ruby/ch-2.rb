#! /usr/bin/ruby

def ascendingnumbers(a)
  np = Regexp.new("^[0-9]+$")
  prev = nil
  a.split(" ").each do |c|
    if c =~ np
      n = c.to_i
      if !prev.nil? && prev >= n
        return false
      end
      prev = n
    end
  end
  true
end

require 'test/unit'

class TestAscendingnumbers < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, ascendingnumbers('The cat has 3 kittens 7 toys 10 beds'))
  end

  def test_ex2
    assert_equal(false, ascendingnumbers('Alice bought 5 apples 2 oranges 9 bananas'))
  end

  def test_ex3
    assert_equal(true, ascendingnumbers('I ran 1 mile 2 days 3 weeks 4 months'))
  end

  def test_ex4
    assert_equal(false, ascendingnumbers('Bob has 10 cars 10 bikes'))
  end

  def test_ex5
    assert_equal(true, ascendingnumbers('Zero is 0 one is 1 two is 2'))
  end

end
