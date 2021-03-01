#! /usr/bin/ruby

require 'test/unit'

def hcs(n)
  s=Array.new
  t=Array.new
  while 1
    s=Array.new
    l=0
    if t.length>0 then
      s=t.pop
      l=s.map{|i| (i==1 ? 0 : "#{i}".length)+1}.sum
    end
    if l==n then
      break
    end
    if l > n then
      next
    end
    c=l
    while 1
      tt=((c==1)?0:"#{c}".length)+l+1
      if c==tt then
        k=s[0..-1]
        k.push(c)
        t.push(k)
      end
      if c > tt then
        break
      end
      c+=1
    end
  end
  return s.map{|i| (i==1?"":"#{i}") + "#"}.join('')
end

class TestHcs < Test::Unit::TestCase

  def test_ex1
    assert_equal('#',hcs(1))
  end

  def test_ex2
    assert_equal('2#',hcs(2))
  end

  def test_ex3
    assert_equal('#3#',hcs(3))
  end

  def test_ex4
    assert_equal('#3#5#7#10#',hcs(10))
  end

  def test_ex5
    assert_equal('2#4#6#8#11#14#',hcs(14))
  end

end
