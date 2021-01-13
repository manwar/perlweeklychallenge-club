#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Leader Elements", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same({10, 7, 6, 1}, t1.leaders({9, 10, 7, 5, 6, 1}))
    assert.are.same({5}, t1.leaders({3, 4, 5}))
  end)
end)

describe("Task 2, Left Rotation", function()
  local t2  = require'ch-2'
  it("produces correct results for the examples", function()
    assert.are.same(
      {{40, 50, 10, 20, 30}, {50, 10, 20, 30, 40}},
      t2.multi_rotate({10, 20, 30, 40, 50}, {3, 4})
    )
    assert.are.same(
      {{4, 2, 6, 3, 7}, {6, 3, 7, 4, 2}, {3, 7, 4, 2, 6}},
      t2.multi_rotate({7, 4, 2, 6, 3}, {1, 3, 4})
    )
  end)
end)
