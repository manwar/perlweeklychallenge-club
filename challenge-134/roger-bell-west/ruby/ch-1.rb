#! /usr/bin/ruby

def pandigital(count)
  digits=1
  cc=1
  while cc<count do
    digits += 1
    cc *= digits
    if digits > 10 then
      return []
    end
  end
  template=(2..9).to_a
  template.unshift(0)
  template.unshift(1)
  template.reverse!
  lead=template[digits..-1].reverse
  template=template[0..digits-1]
  o=[]
  template.permutation do |r|
    o.push(r.join)
  end
  o.sort!
  o=o[0..count-1]
  l=lead.join
  return o.map{|j| (l+j).to_i}
end

require 'test/unit'

class TestIsqrt < Test::Unit::TestCase

  def test_ex1
    assert_equal([1023456789, 1023456798, 1023456879, 1023456897, 1023456978, 1023456987, 1023457689, 1023457698, 1023457869, 1023457896],pandigital(10))
  end

end
