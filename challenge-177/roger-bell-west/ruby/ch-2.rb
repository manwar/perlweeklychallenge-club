#! /usr/bin/ruby

require 'test/unit'

require 'prime'

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
    assert_equal([ 101, 16061, 31013, 35053, 38083, 73037, 74047,
                   91019, 94049, 1120211, 1150511, 1160611, 1180811,
                   1190911, 1250521, 1280821, 1360631, 1390931,
                   1490941, 1520251 ],
                 ppc(20))
  end

end
