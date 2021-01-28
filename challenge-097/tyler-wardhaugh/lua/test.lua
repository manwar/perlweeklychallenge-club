#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Caesar Cipher", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same("QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD",
      t1.caesar("THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", 3))
  end)
end)


describe("Task 2, Binary Substrings", function()
  local t2 = require'ch-2'
  it("produces correct results for the examples", function()
    assert.are.same(1, t2.binary_substrings("101100101", 3))
    assert.are.same(2, t2.binary_substrings("10110111", 4))
  end)
end)
