#! /usr/bin/ruby

def formatphonenumber(a)
  pure = a.chars.filter{|x| x >= '0' && x <= '9'}
    left = pure.size
    out = []
    i = 0
    if left > 4
        pure.each do |c|
            out.push(*c)
            i += 1
            left -= 1
            if i % 3 == 0
                out.push('-')
                if left <= 4
                    break
                end
            end
        end
    end
    if left == 4
        out.push(pure[i])
        out.push(pure[i + 1])
        out.push('-')
        i += 2
    end
    i.upto(pure.size - 1) do |p|
        out.push(pure[p])
    end
    out.join("")
end

require 'test/unit'

class TestFormatphonenumber < Test::Unit::TestCase

  def test_ex1
    assert_equal('123-456', formatphonenumber('1-23-45-6'))
  end

  def test_ex2
    assert_equal('12-34', formatphonenumber('1234'))
  end

  def test_ex3
    assert_equal('123-456-789', formatphonenumber('12 345-6789'))
  end

  def test_ex4
    assert_equal('123-45-67', formatphonenumber('123 4567'))
  end

  def test_ex5
    assert_equal('123-456-78', formatphonenumber('123 456-78'))
  end

end
