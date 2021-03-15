#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, Reverse Words", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    assert.are.same("Challenge Weekly The", t1.reverse_words("The Weekly Challenge"))
    assert.are.same("family same the of part are Raku and Perl",
      t1.reverse_words("    Perl and   Raku are  part of the same family  "))
  end)
end)


describe("Task 2, Edit Distance", function()
  local t2 = require'ch-2'
  it("produces correct results for the examples", function()
    assert.are.same(3, t2.edit_distance("kitten", "sitting"))
    assert.are.same(2, t2.edit_distance("sunday", "monday"))
  end)
end)
