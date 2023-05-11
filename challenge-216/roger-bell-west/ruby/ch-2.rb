#! /usr/bin/ruby

def word2map(word)
  m = Hash.new
  word.downcase.chars.find_all {|i| i >= 'a' && i <= 'z'}.each do |c|
    if m.has_key?(c) then
      m[c] += 1
    else
      m[c] = 1
    end
  end
  return m
end

def wordstickers(stickers, word)
  w = word2map(word)
  t = Marshal.load(Marshal.dump(w))
  stick = []
  stickers.each do |s|
    f = word2map(s)
    f.keys.each do |c|
      t.delete(c)
    end
    stick.push(f)
  end
  if t.length > 0 then
    return 0
  end
  stack = [ [w, 0] ]
  while stack.length > 0 do
    st = stack.shift
    if st[0].length == 0 then
      return st[1]
    else
      n = st[1] + 1
      stick.each do |sti|
        sp = Marshal.load(Marshal.dump(st[0]))
        v = false
        sti.keys.each do |l|
          if sp.has_key?(l) then
            v = true
            p = sp[l] - sti[l]
            if p > 0 then
              sp[l] = p
            else
              sp.delete(l)
            end
          end
        end
        if v then
          stack.push([sp, n])
        end
      end
    end
  end
end

require 'test/unit'

class TestWordstickers < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, wordstickers(['perl', 'raku', 'python'], 'peon'))
  end

  def test_ex2
    assert_equal(3, wordstickers(['love', 'hate', 'angry'], 'goat'))
  end

  def test_ex3
    assert_equal(4, wordstickers(['come', 'nation', 'delta'], 'accomodation'))
  end

  def test_ex4
    assert_equal(0, wordstickers(['come', 'country', 'delta'], 'accomodation'))
  end

end
