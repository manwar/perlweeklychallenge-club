#! /usr/bin/ruby

require 'test/unit'

$p = [676.5203681218851,
      -1259.1392167224028,
      771.32342877765313,
      -176.61502916214059,
      12.507343278686905,
      -0.13857109526572012,
      9.9843695780195716e-6,
      1.5056327351493116e-7]

EPSILON = 1e-7
PI = 3.145926536

def drop_imag(z0)
  z = z0
  if z0.imag.abs <= EPSILON then
    z = Complex(z.real,0)
  end
  return z
end

def gamma(z0)
  z = Complex(z0, 0)
  y = Complex(0, 0)
  if z.real < 0.5 then
    y = PI / ((PI * z).sin * gamma(1 - z.re))
  else
    z -= 1
    x = 0.99999999999980993
    $p.each_with_index do |pval, i|
      x += pval / (z + i + 1)
    end
    t = z + $p.length - 0.5
    y = Math.sqrt(2 * PI) * t ** (z + 0.5) * Math.exp(-t) * x
  end
  return drop_imag(y)
end

class TestLanczos < Test::Unit::TestCase

  def test_ex1
    assert_in_delta(2,gamma(3),EPSILON)
  end

  def test_ex2
    assert_in_delta(24,gamma(5),EPSILON)
  end

  def test_ex3
    assert_in_delta(720,gamma(7),EPSILON)
  end

end

print(gamma(3))
print("\n")
print(gamma(5))
print("\n")
print(gamma(7))
print("\n")
