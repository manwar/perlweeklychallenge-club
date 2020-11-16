#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Triplet Sum", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same(t1.pair_difference(7, {10, 8, 12, 15, 5}), 1)
    assert.are.same(t1.pair_difference(6, {1, 5, 2, 9, 7}), 1)
    assert.are.same(t1.pair_difference(15, {10, 30, 20, 50, 40}), 0)
    assert.are.same(t1.pair_difference(0, {100, 1, 2, 3, 4, 5, 100, 999, 999}), 1)
    assert.are.same(t1.pair_difference(0, {100, 1, 2, 3, 4, 5, 101}), 0)
  end)
end)

describe("Task 2, Sudoku Puzzle", function()
  local t2 = require'ch-2'
  it("produces correct results for the examples", function()
    assert.truthy(t2.solve(t2.slurp('../clojure/resources/sudoku-1')))
    assert.truthy(t2.solve(t2.slurp('../clojure/resources/sudoku-2')))
    assert.truthy(t2.solve(t2.slurp('../clojure/resources/sudoku-3')))
  end)
end)
