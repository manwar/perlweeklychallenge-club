#! /usr/bin/ruby

require 'set'

def fp(delims,sample)
  d=[Set.new,Set.new]
  0.upto(delims.length-1) do |i|
    d[i%2].add(delims[i])
  end
  o=[[],[]]
  sample.chars do |s|
    0.upto(1) do |x|
      if d[x].include?(s) then
        o[x].push(s)
      end
    end
  end
  return o.map{|j| j.join("")}
end

require 'test/unit'

class TestFp < Test::Unit::TestCase

def test_ex1
  assert_equal(['"(["','")]"'],fp('""[]()','"I like (parens) and the Apple ][+" they said.'))
end

  def test_ex2
    assert_equal(['/**/<','/**/>'],fp('**//<>','/* This is a comment (in some languages) */ <could be a tag>'))
  end
  
end
