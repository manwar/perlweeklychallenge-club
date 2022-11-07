#! /usr/bin/ruby

require 'test/unit'

require 'set'

def decodedlist(s)
  stack = [[s]]
  out = Set.new
  while true do
    ent = stack.shift
    tail = ent.pop
    if tail.length == 0 then
      out.add(Marshal.dump(ent))
    else
      if tail[0] != "0" then
        q = ent[0..-1]
        q.push(tail[0])
        q.push(tail[1..-1])
        stack.push(q)
      end
      if tail.length >= 2 then
        v = tail[0..1].to_i
        if v >=1  and v <= 26 then
          q = ent[0..-1]
          q.push(tail[0..1])
          q.push(tail[2..-1])
          stack.push(q)
        end
      end
    end
    if stack.length == 0 then
      break
    end
  end
  k = []
  alphazero = "A".ord - 1
  out.each do |x|
    k.push(Marshal.load(x).map{|cs| (cs.to_i + alphazero).chr}.join(""))
  end
  return k.sort
end

class TestDecodecounts < Test::Unit::TestCase

  def test_ex1
    assert_equal(["AA", "K"], decodedlist("11"));
  end

  def test_ex2
    assert_equal(["AAAE", "AAO", "AKE", "KAE", "KO"], decodedlist("1115"));
  end

  def test_ex3
    assert_equal(["ABG", "LG"], decodedlist("127"));
  end
end
