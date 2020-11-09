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

describe("Task 2, Find Square", function()
  local t2 = require'ch-2'
  it("produces correct results for the examples", function()
    assert.are.same(t2.count_squares(t2.parse_matrix_file('../clojure/resources/matrix-1')), 1)
    assert.are.same(t2.count_squares(t2.parse_matrix_file('../clojure/resources/matrix-2')), 4)
    assert.are.same(t2.count_squares(t2.parse_matrix_file('../clojure/resources/matrix-3')), 0)
  end)
end)
