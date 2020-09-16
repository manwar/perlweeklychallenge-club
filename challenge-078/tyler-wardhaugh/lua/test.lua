#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Leader Elements", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same({10, 7, 6, 1}, t1.leaders({9, 10, 7, 5, 6, 1}))
    assert.are.same({5}, t1.leaders({3, 4, 5}))
  end)
end)
