#! /usr/bin/ruby
# coding: utf-8

require 'test/unit'

require 'set'

def mr(n)
  f=Set.new
  File.foreach(n) do |line|
    if line =~ /(^[0-9]+)/ then
      f.add($1.to_i)
    end
  end
  a=1
  while 1
    if !f.include?(a) then
      return a
    end
    a+=1
  end
end

class TestNs < Test::Unit::TestCase

  def test_ex1
    assert_equal(12,mr("infile"))
  end
  
end
