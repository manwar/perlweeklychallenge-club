#! /usr/bin/ruby

require 'test/unit'

require 'set'

def fds(n)
  o=[]
  f=[1,0]
  ft=Set.new(f)
  k=0
  while o.length < n do
    ds=0
    j=k
    while j > 0 do
      ds += j % 10
      j = (j/10).to_i
    end
    while f[0] < ds do
      t=f[1]+f[0]
      f[1]=f[0]
      f[0]=t
      ft.add(f[0])
    end
    if ft.include?(ds) then
      o.push(k)
    end
    k += 1
  end
  return o
end

class TestFds < Test::Unit::TestCase

  def test_ex1
    assert_equal([0, 1, 2, 3, 5, 8, 10, 11],fds(8))
  end

  def test_ex2
    assert_equal([0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44],fds(20))
  end

  def test_ex3
    assert_equal([0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44, 49, 50, 53, 58, 62, 67, 71, 76, 80, 85, 94, 100, 101, 102, 104, 107, 110, 111, 113, 116, 120, 122, 125, 131, 134, 139, 140, 143, 148, 152, 157, 161, 166, 170, 175, 184, 193, 200, 201, 203, 206],fds(61))
  end

end
