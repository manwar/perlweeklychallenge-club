#! /usr/bin/ruby

def str2hash(a)
  m = Hash.new(0)
  a.split('').each do |c|
    if c.match(/[[:alpha:]]/) then
      m[c.downcase] += 1
    end
  end
  return m
end

def completingword(a, cw)
  ah = str2hash(a)
  out = []
  cw.each do |t|
    valid = true
    th = str2hash(t)
    ah.each do |k, v|
      if !th.has_key?(k) then
        valid = false
        break
      end
      if th[k] < v then
        valid = false
        break
      end
    end
    if valid then
      out.push(t)
    end
  end
  if out.length == 0 then
    return ""
  end
  return out.sort_by { |x| x.length }[0]
end

require 'test/unit'

class TestCompletingword < Test::Unit::TestCase

  def test_ex1
    assert_equal('accbbb', completingword('aBc 11c', ['accbbb', 'abc', 'abbc']))
  end

  def test_ex2
    assert_equal('baacl', completingword('La1 abc', ['abcl', 'baacl', 'abaalc']))
  end

  def test_ex3
    assert_equal('bjb', completingword('JB 007', ['jj', 'bb', 'bjb']))
  end

end
