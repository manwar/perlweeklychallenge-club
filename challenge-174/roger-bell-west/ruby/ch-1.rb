#! /usr/bin/ruby

require 'test/unit'

def disarium(ct)
  o = []
  pows = [ Array.new(10) { 1 } ]
  c = 0
  while true do
    disar = 0
    if c > 0 then
      ca = c
      cl = []
      tx = 0
      while ca > 0 do
        tx += 1
        ca,cx = ca.divmod(10)
        cl.push(cx)
      end
      cl = cl.reverse
      if tx >= pows.length then
        pows.length.upto(tx) do |power|
          row = []
          0.upto(9) do |digit|
            row.push(pows[power-1][digit] * digit)
          end
          pows.push(row)
        end
      end
      cl.each_with_index do |e,i|
        disar += pows[i+1][e]
      end
    end
    if disar == c then
      o.push(c)
      if o.length >= ct then
        break
      end
    end
    c += 1
  end
  return o
end


class TestDisarium < Test::Unit::TestCase

  def test_ex1
    assert_equal([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 89, 135, 175, 518,
                   598, 1306, 1676, 2427, 2646798 ],disarium(19))
  end

end
