#! /usr/bin/ruby

def collectpoints(a)
  m = []
  s = 0
  while s < a.length do
    k = a[s]
    e = s
    while e < a.length && a[e] == k do
      e += 1
    end
    m.push([k, e - s])
    s = e
  end
  rv = 0
  stack = [[m, 0]]
  while stack.length > 0 do
    s = stack.pop
    if s[0].length == 0 then
      rv = [rv, s[1]].max
    else
      0.upto(s[0].length - 1) do |i|
        ss = Marshal.load(Marshal.dump(s))
        ss[1] += ss[0][i][1] * ss[0][i][1]
        ss[0].delete_at(i)
        j = i
        while true do
          if j > 0 && j < ss[0].length && ss[0][j][0] == ss[0][j-1][0] then
            ss[0][j][1] += ss[0][j-1][1]
            ss[0].delete_at(j - 1)
            j -= 1
          else
            break
          end
        end
        stack.push(ss)
      end
    end
  end
  return rv
end

require 'test/unit'

class TestCollectpoints < Test::Unit::TestCase

  def test_ex1
    assert_equal(23, collectpoints([2, 4, 3, 3, 3, 4, 5, 4, 2]))
  end

  def test_ex2
    assert_equal(20, collectpoints([1, 2, 2, 2, 2, 1]))
  end

  def test_ex3
    assert_equal(1, collectpoints([1]))
  end

  def test_ex4
    assert_equal(40, collectpoints([2, 2, 2, 1, 1, 2, 2, 2]))
  end

end
