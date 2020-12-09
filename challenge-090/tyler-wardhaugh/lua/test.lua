#!/usr/bin/env lua

require 'busted.runner'()

describe("Task 1, DNA Sequence", function()
  local t1 = require'ch-1'
  it("produces correct results for the examples", function()
    local freq, complement = t1.process_dna(t1.DEFAULT_DNA)
    assert.are.same({G=13, T=22, A=14, C=18 }, freq)
    assert.are.same('CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC',
      complement)
  end)
end)

describe("Task 2, Ethiopian Multiplication", function()
  local t2 = require'ch-2'
  it("produces correct results for the examples", function()
    assert.are.same(168, t2.ethiopian_multiply(12, 14))
    assert.are.same(1554, t2.ethiopian_multiply(37, 42))
  end)
end)
