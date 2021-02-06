#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Read N-Characters", function()
  local t1 = require'ch-1'
  local input_filename = '../clojure/resources/input.txt'
  it("produces correct results for the examples", function()
    assert.are.same("1234", t1.readN(input_filename, 4))
    assert.are.same("5678", t1.readN(input_filename, 4))
    assert.are.same("90", t1.readN(input_filename, 4))
  end)
end)


describe("Task 2, Search Insert Position", function()
  local t2 = require'ch-2'
  it("produces correct results for the examples", function()
    assert.are.same(2, t2.search_insert_position({1, 2, 3, 4}, 3))
    assert.are.same(3, t2.search_insert_position({1, 3, 5, 7}, 6))
    assert.are.same(0, t2.search_insert_position({12, 14, 16, 18}, 10))
    assert.are.same(4, t2.search_insert_position({11, 13, 15, 17}, 19))
  end)
end)
