#! /usr/bin/ruby

require 'test/unit'

def r2qi(n)
  return c2qi(n, 0)
end

def c2qi(r0, i0)
  l = []
  [i0, r0].each do |n0|
    n = n0
    digits = []
    while n != 0 do
      (n, digit) = n.divmod(-4)
      if digit < 0 then
        digit += 4
        n += 1
      end
      digits.push(digit)
    end
    l.push(digits)
  end
  ld = l[0].length - l[1].length
  if ld < 0 then
    l[0] = ([0] * (-ld-1)).concat(l[0])
  else
    l[1] = ([0] * ld).concat(l[1])
  end
  o = ""
  (l[1].length-1).downto(0) do |i|
    0.upto(1) do |b|
      if l[b].length > i then
        o += l[b][i].to_s
      end
    end
  end
  return o
end

def qi2r(n)
  return qi2c(n)[0]
end

def qi2c(n)
  pow = 1
  ri = 0
  o = [0, 0]
  n.to_s.reverse.chars do |ch|
    o[ri] += ch.to_i * pow
    ri += 1
    pow *= 2
    if ri == 2 then
      ri = 0
      pow = -pow
    end
  end
  return o
end

def ppc(ct)
  o = []
  fh = 0
  while o.length() < ct do
    fh += 1
    t = fh
    q = false
    while t > 0 do
      (t,d) = t.divmod(10)
      if d == 0 then
        q = true
        break
      end
    end
    if q then
      next
    end
    sfh = fh.to_s
    c = (sfh + "0" + sfh.reverse).to_i
    if c.prime? then
      o.push(c)
    end
  end
  return o
end

class TestReversible < Test::Unit::TestCase

  def test_ex1
    assert_equal("10300", r2qi(4))
  end

  def test_ex2
    assert_equal(4, qi2r("10300"))
  end

end
