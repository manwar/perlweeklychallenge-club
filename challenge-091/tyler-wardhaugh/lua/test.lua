#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Count Number", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same(21321314, t1.count_numbers(1122234))
    assert.are.same(12332415, t1.count_numbers(2333445))
    assert.are.same(1112131415, t1.count_numbers(12345))
  end)
end)

describe("Task 2, Jump Game", function()
  local t2 = require'ch-2'
  it("produces correct results for the examples", function()
    assert.truthy(t2.jump_game{1, 2, 1, 2})
    assert.falsy(t2.jump_game{2, 1, 1, 0, 2})
  end)
end)
