#! /usr/bin/ruby

class Stack

  def initialize
    @stack=Array.new
  end

  def push(op)
    @stack.push(op)
  end

  def pop
    if @stack.length()==0 then
      raise("insufficient elements for pop")
    end
    return @stack.pop
  end

  def top
    if @stack.length()==0 then
      raise("insufficient elements for top")
    end
    return @stack[-1]
  end

  def min
    if @stack.length()==0 then
      raise("insufficient elements for min")
    end
    return @stack.min
  end

end

require 'test/unit'

class TestStack < Test::Unit::TestCase

    def test_ex1
        stack=Stack.new
        stack.push(2)
        stack.push(-1)
        stack.push(0)
        assert_equal(0,stack.pop,'example 1')
    end

    def test_ex2
        stack=Stack.new
        stack.push(2)
        stack.push(-1)
        stack.push(0)
        stack.pop
        assert_equal(-1,stack.top,'example 2')
    end

    def test_ex3
        stack=Stack.new
        stack.push(2)
        stack.push(-1)
        stack.push(0)
        stack.pop
        stack.push(0)
        assert_equal(-1,stack.min,'example 3')
    end

end
