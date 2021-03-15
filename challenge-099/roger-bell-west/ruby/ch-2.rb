#! /usr/bin/ruby

def us(text,match)
  s=Hash.new
  text.split(//).each_with_index do |c,i|
    unless s[c] then
      s[c]=Array.new
    end
    s[c].push(i)
  end
  j=Array.new;
  match.split(//).each do |c|
    if s.has_key?(c) then
      j.push(s[c])
    else
      return 0
    end
  end
  o=Array.new([1] * j[0].length)
  1.upto(j.length-1) do |m|
    n=Array.new
    0.upto(j[m].length-1) do |bi|
      t=0
      0.upto(j[m-1].length-1) do |ai|
        if j[m-1][ai] < j[m][bi] then
          t += o[ai]
        end
      end
      n.push(t)
    end
    o=n
  end
  return o.sum
end

require 'test/unit'

class TestUs < Test::Unit::TestCase

  def test_ex1
    assert_equal(5,us('littleit','lit'))
  end

  def test_ex2
    assert_equal(3,us('london','lon'))
  end

end
