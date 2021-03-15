#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Pattern Match", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.truthy(t1.pattern_match("abcde", "a*e"))
    assert.are.falsy(t1.pattern_match("abcde", "a*d"))
    assert.are.falsy(t1.pattern_match("abcde", "?b*d"))
    assert.are.truthy(t1.pattern_match("abcde", "a*c?e"))
  end)
end)


describe("Task 2, Unique Subsequences", function()
  local t2 = require'ch-2'
  it("produces correct results for the examples", function()
    assert.are.same(5, t2.unique_subsequences("littleit", "lit"))
    assert.are.same(3, t2.unique_subsequences("london", "lon"))
  end)
end)
