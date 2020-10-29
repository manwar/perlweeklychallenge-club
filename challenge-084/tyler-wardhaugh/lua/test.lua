#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Reverse Integer", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same(t1.reverse_integer('1234'), 4321)
    assert.are.same(t1.reverse_integer('-1234'), -4321)
    assert.are.same(t1.reverse_integer('1231230512'), 0)
  end)
end)
