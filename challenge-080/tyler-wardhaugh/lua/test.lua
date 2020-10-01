#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Smallest Positive Number", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same(t1.smallest_missing({5, 2, -2, 0}), 1)
    assert.are.same(t1.smallest_missing({1, 8, -1}), 2)
    assert.are.same(t1.smallest_missing({2, 0, -1}), 1)
    assert.are.same(t1.smallest_missing({-5, -4, -3}), 1)
    assert.are.same(t1.smallest_missing({1, 2, 3, 10000000}), 4)
    assert.are.same(t1.smallest_missing({1, 4, 2, 3}), 5)
  end)
end)

describe("Task 2, Count Candies", function()
  local t2  = require'ch-2'
  it("produces correct results for the examples", function()
    assert.are.same(t2.count_candies({1, 2, 2}), 4)
    assert.are.same(t2.count_candies({1, 4, 3, 2}), 7)
    assert.are.same(t2.count_candies({2, 1, 4, 3, 1, 2}), 11)
  end)
end)
