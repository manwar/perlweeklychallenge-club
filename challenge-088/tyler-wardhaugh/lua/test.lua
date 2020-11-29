#!/usr/bin/env lua

require 'busted.runner'()
MATRIX_FILE_PREFIX = '../clojure/resources/matrix-'

describe("Task 1, Array of Product", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same({24, 60, 120, 30, 40}, t1.array_of_product({5, 2, 1, 4, 3}))
    assert.are.same({12, 24, 6, 8}, t1.array_of_product({2, 1, 4, 3}))
  end)
end)

describe("Task 2, Spiral Matrix", function()
  local t2 = require'ch-2'
  local util = require'util'
  local helper = function(n)
    return t2.spiral(util.parse_matrix_file(MATRIX_FILE_PREFIX .. n))
  end
  it("produces correct results for the examples", function()
    assert.are.same({1, 2, 3, 6, 9, 8, 7, 4, 5}, helper('1'))
    assert.are.same({1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10}, helper('2'))
  end)
end)
