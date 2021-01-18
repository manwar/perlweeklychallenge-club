#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Group Anagrams", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same(
      {
        abt={'bat', 'tab'},
        asw={'saw', 'was'},
        opt={'opt', 'pot', 'top'}
      },
      t1.group_anagrams({"opt", "bat", "saw", "tab", "pot", "top", "was"}))
    assert.are.same({x={'x'}}, t1.group_anagrams({"x"}))
  end)
end)

describe("Task 2, Binary Tree to Linked List", function()
  local t2 = require'ch-2'
  it("produces correct results for the examples", function()
    assert.are.same(
      { 1, 2, 4, 5, 6, 7, 3 },
      t2.tree_to_linked_list({1, {2, {4}, {5, {6}, {7}}}, {3}})
      )
  end)
end)
