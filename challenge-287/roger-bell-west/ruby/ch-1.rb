#! /usr/bin/ruby

def strongpassword(a)
  ctypes = Hash.new
  ctypes.default = 0
  reps = 0
  rep = 0
  old = '@'
  changes = Array.new
  a.chars.each_with_index do |c, i|
    if i > 0 && c == old 
      rep += 1
      if rep >= 2 
        reps += 1
      end
    else
      rep = 0
      old = c
    end
    t = 'n'
    if c >= 'A' && c <= 'Z'
      t = 'u'
    elsif c >= 'a' && c <= 'z'
      t = 'l'
    elsif c >= '0' && c <= '9'
      t = 'd'
    end
    ctypes[t] += 1
  end
  changes.push(reps)
  ctypes.delete('n')
  k = ctypes.keys.size
  if k < 3
    spare = ctypes.values.sum - k
    if spare < 0
      changes.push(-spare)
    end
  end
  if a.size < 6
    changes.push(6 - a.size)
  end
  changes.max
end

require 'test/unit'

class TestStrongpassword < Test::Unit::TestCase

  def test_ex1
    assert_equal(5, strongpassword('a'))
  end

  def test_ex2
    assert_equal(3, strongpassword('aB2'))
  end

  def test_ex3
    assert_equal(0, strongpassword('PaaSW0rd'))
  end

  def test_ex4
    assert_equal(1, strongpassword('Paaasw0rd'))
  end

  def test_ex5
    assert_equal(3, strongpassword('aaaaa'))
  end

end
