#! /usr/bin/ruby

def secretsanta(n)
  case n
  when 0
    1
  when 1
    0
  else
    (n - 1) * (secretsanta(n - 1) + secretsanta(n - 2))
  end
end

require 'test/unit'

class TestSecretsanta < Test::Unit::TestCase

  def test_ex1
    assert_equal(0, secretsanta(1))
  end

  def test_ex2
    assert_equal(1, secretsanta(2))
  end

  def test_ex3
    assert_equal(2, secretsanta(3))
  end

  def test_ex4
    assert_equal(9, secretsanta(4))
  end

  def test_ex5
    assert_equal(44, secretsanta(5))
  end

end
