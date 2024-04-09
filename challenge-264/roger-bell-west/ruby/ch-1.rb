#! /usr/bin/ruby

def greatestenglishletter(a)
  m = Hash.new(0)
  a.split('').each do |c|
    uc = c.upcase
    flag = (c == uc) ? 1 : 2
    m[uc] |= flag
  end
  s = m.keys.find_all{|k| m[k] == 3}
  if s.length > 0 then
    return s.sort[-1]
  else
    return ""
  end
end

require 'test/unit'

class TestGreatestenglishletter < Test::Unit::TestCase

  def test_ex1
    assert_equal('L', greatestenglishletter('PeRlwEeKLy'))
  end

  def test_ex2
    assert_equal('L', greatestenglishletter('ChaLlenge'))
  end

  def test_ex3
    assert_equal('', greatestenglishletter('The'))
  end

end
