#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Common Factors", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same(t1.common_factors(12, 18), {1, 2, 3, 6})
    assert.are.same(t1.common_factors(18, 23), {1})
  end)
end)

describe("Task 2, Interleave Strings", function()
  local t2 = require'ch-2'
  it("produces correct results for the examples", function()
    assert.are.same(t2.interleave_string("XY", "X", "XXY"), true)
    assert.are.same(t2.interleave_string("XXY", "XXZ", "XXXXZY"), true)
    assert.are.same(t2.interleave_string("YX", "X", "XXY"), false)
  end)
end)
