#! /usr/bin/ruby

require 'test/unit'

def hexwords(lo,hi,sb)
  out = []
  File.open('dictionary.txt','r') do |fh|
    fh.each_line("\n") do |line|
      line = line.chomp
      if line.length >= lo && line.length <= hi then
        valid = true
        sbc = 0
        line.chars do |c|
          if c == 'o' || c == 'i' || c == 'l' || c == 's' || c == 't' then
            sbc += 1
            if sbc > sb then
              valid = false
            end
          elsif c < 'a' || c > 'f' then
            valid = false
          end
          if !valid then
            break
          end
        end
        if valid then
          out.push(line)
        end
      end
    end
  end
  return out
end

def combiwords(wl,l)
  wh = Hash.new
  wl.each do |w|
    lx = w.length
    if !wh.has_key?(lx) then
      wh[lx] = []
    end
    wh[lx].push(w)
  end
  tmap = [ [] ]
  omap = []
  while tmap.length > 0 do
    c = tmap.pop
    s = c.sum
    1.upto(l-s-1) do |j|
      if wh.has_key?(j) then
        cc = c[0..-1]
        cc.push(j)
        tmap.push(cc)
      end
    end
    if wh.has_key?(l-s) then
      c.push(l-s)
      omap.push(c)
    end
  end
  out = []
  omap.each do |pat|
    wh[pat[0]].product(pat[1..-1].collect{|i| wh[i]}.flatten).each do |w|
      out.push(w.join(""))
    end
  end
  return out
end

class TestHexwords < Test::Unit::TestCase

  def test_ex1
    assert_equal(1463,
                 hexwords(2,8,8).length)
  end
  
  def test_ex2
    assert_equal(164,
                 hexwords(8,8,8).length)
  end
  
  def test_ex3
    assert_equal(45,
                 hexwords(2,8,0).length)
  end

  def test_ex4
    assert_equal(244,
                 hexwords(2,8,1).length)
  end

  def test_ex5
    assert_equal(144,
                 combiwords(hexwords(4,4,0),8).length)
  end

  def test_ex6
    assert_equal(274,
                 combiwords(hexwords(3,5,0),8).length)
  end
  
end

