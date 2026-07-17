#! /usr/bin/ruby

def replacequestionmark(a)
  template = a.chars.to_a
  q = template.select{|x| x == '?'}.size
  if q == 0
    return [a]
  end
  out = []
  0.upto((1 << q)-1) do |n|
    qm = []
    nn = n
    while nn > 0
      if nn % 2 == 1
        qm.push('1')
      else
        qm.push('0')
      end
      nn = nn.div(2)
    end
    while qm.size < q
      qm.push('0')
    end
    entry = ""
    template.each do |tc|
      entry += (
        case tc
        when '?'
          qm.pop
        else
          tc
        end
      )
    end
    out.push(entry)
  end
  out
end

require 'test/unit'

class TestReplacequestionmark < Test::Unit::TestCase

  def test_ex1
    assert_equal(['01000', '01010', '01100', '01110'], replacequestionmark('01??0'))
  end

  def test_ex2
    assert_equal(['101'], replacequestionmark('101'))
  end

  def test_ex3
    assert_equal(['000', '001', '010', '011', '100', '101', '110', '111'], replacequestionmark('???'))
  end

  def test_ex4
    assert_equal(['1010', '1110'], replacequestionmark('1?10'))
  end

  def test_ex5
    assert_equal(['10100', '10110', '11100', '11110'], replacequestionmark('1?1?0'))
  end

end
