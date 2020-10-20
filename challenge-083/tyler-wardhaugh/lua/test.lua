#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Words Length", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same(t1.inner_words_length"The Weekly Challenge", 6)
    assert.are.same(t1.inner_words_length"The purpose of our lives is to be happy", 23)
    assert.are.same(t1.inner_words_length"Zero when-no-inner-words-exist!", 0)
  end)
end)
