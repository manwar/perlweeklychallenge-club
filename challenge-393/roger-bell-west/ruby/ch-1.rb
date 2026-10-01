#! /usr/bin/ruby

def pythagorasmultiplied(n)
  squared = Hash.new
  ct = 0
  5.upto(n) do |c|
    unless squared.has_key?(c)
      squared[c] = c * c
    end
    1.upto(c - 2) do |a|
      unless squared.has_key?(a)
        squared[a] = a * a
      end
      (a + 1).upto(c - 1) do |b|
        unless squared.has_key?(b)
          squared[b] = b * b
        end
        tot = squared[a] + squared[b]
        if tot > squared[c]
          break
        end
        if tot == squared[c]
          ct += 1
        end
      end
    end
  end
  ct * 2
end

require 'test/unit'

class TestPythagorasmultiplied < Test::Unit::TestCase

  def test_ex1
    assert_equal(12, pythagorasmultiplied(20))
  end

  def test_ex2
    assert_equal(2, pythagorasmultiplied(7))
  end

  def test_ex3
    assert_equal(0, pythagorasmultiplied(1))
  end

  def test_ex4
    assert_equal(8, pythagorasmultiplied(15))
  end

  def test_ex5
    assert_equal(22, pythagorasmultiplied(30))
  end

end
