#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Common Factors", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same(t1.common_factors(12, 18), {1, 2, 3, 6})
    assert.are.same(t1.common_factors(18, 23), {1})
  end)
end)
