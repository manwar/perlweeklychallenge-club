#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Fun Time", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same('17:15', t1.fun_time('05:15 pm'))
    assert.are.same('17:15', t1.fun_time('05:15pm'))
    assert.are.same('07:15PM', t1.fun_time('19:15'))
  end)
end)

describe("Task 2, Triangle Sum", function()
  local t2 = require'ch-2'
  it("produces correct results for the examples", function()
    assert.are.same(8, t2.min_triangle_sum({ {1}, {2,4}, {6,4,9}, {5,1,7,2} }))
    assert.are.same(7, t2.min_triangle_sum({ {3}, {3,1}, {5,2,3}, {4,3,1,3} }))
  end)
end)
