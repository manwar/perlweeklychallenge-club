#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Triplet Sum", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same(1, t1.find_triplet_sum({1.2, 0.4, 0.1, 2.5}))
    assert.are.same(0, t1.find_triplet_sum({0.2, 1.5, 0.9, 1.1}))
    assert.are.same(1, t1.find_triplet_sum({0.5, 1.1, 0.3, 0.7}))

    assert.are.same(0, t1.find_triplet_sum({0, 0.5, 0.5}))
    assert.are.same(0, t1.find_triplet_sum({0.1, 0.2, 0.3}))
    assert.are.same(0, t1.find_triplet_sum({1.1, 0.1}))

    local big = {0.9, 0.8, 0.05}
    for _ = 1,100 do table.insert(big, math.random(2, 1000)) end
    assert.are.same(1, t1.find_triplet_sum(big))
  end)
end)

describe("Task 2, Power of Two Integers", function()
  local t2 = require'ch-2'
  it("produces correct results for the examples", function()
    assert.are.same(1, t2.has_power_expr(8))
    assert.are.same(0, t2.has_power_expr(15))
    assert.are.same(1, t2.has_power_expr(125))
  end)
end)
