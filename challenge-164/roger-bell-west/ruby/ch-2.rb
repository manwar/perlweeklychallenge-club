#! /usr/bin/ruby

require 'test/unit'

require 'set'

def ssd(n0)
  n = n0
  out = 0
  while n > 0 do
    n,d = n.divmod(10)
    out += d * d
  end
  return out
end

def happy(ct)
  hm = {1 => true}
  c = 0
  out = []
  while true do
    c += 1
    if !hm.has_key?(c) then
      v = c
      ss = Set.new([v])
      h = true
      while true do
        if hm.has_key?(v) then
          h = hm[v]
          break
        else
          v = ssd(v)
          if ss.include?(v) then
            h = false
            break
          end
          ss.add(v)
        end
      end
      ss.each { |i| hm[i] = h }
    end
    if hm[c] then
      out.push(c)
      if out.length >= ct then
        break
      end
    end
  end
  return out
end

class TestHappy < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 7, 10, 13, 19, 23, 28, 31],
                 happy(8))
  end

end

