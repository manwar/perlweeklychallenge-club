#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Palindrome Number", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.truthy(t1.is_palindrome(1221))
    assert.falsy(t1.is_palindrome(-101))
    assert.falsy(t1.is_palindrome(90))
  end)
end)
