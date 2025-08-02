#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[sequtils]

proc isReducedRowEchelon(matrix: openarray[seq[int]]): bool =
  var expectZeroes = false
  var leadingIndexes: seq[int]

  for row in matrix:
    # 1.Rows that consist entirely of zeros are at the bottom of the matrix.
    if expectZeroes:
      if row.anyIt(it != 0):
        return false
      continue

    for index, val in row:
      if val == 0:
        if index == row.high:
          expectZeroes = true
        continue

      # 2.Leading 1s are on the right of leading 1s above them.
      if val != 1 or (leadingIndexes.len > 0 and index <= leadingIndexes[^1]):
        return false

      leadingIndexes.add index
      break

  # 3.Each column that contains a leading 1 has zeros everywhere else in that column.
  for leadRow, leadCol in leadingIndexes:
    for row in 0 .. matrix.high:
      if row == leadRow:
        continue
      if matrix[row][leadCol] != 0:
        return false

  true

when isMainModule:
  import std/unittest

  const
    TestMatrices = [
      @[@[1, 1, 0], @[0, 1, 0], @[0, 0, 0]],
      @[@[0, 1, -2, 0, 1], @[0, 0, 0, 1, 3], @[0, 0, 0, 0, 0], @[0, 0, 0, 0, 0]],
      @[@[1, 0, 0, 4], @[0, 1, 0, 7], @[0, 0, 1, -1]],
      @[@[0, 1, -2, 0, 1], @[0, 0, 0, 0, 0], @[0, 0, 0, 1, 3], @[0, 0, 0, 0, 0]],
      @[@[0, 1, 0], @[1, 0, 0], @[0, 0, 0]],
      @[@[4, 0, 0, 0], @[0, 1, 0, 7], @[0, 0, 1, -1]]
    ]
    Expected = [false, true, true, false, false, false]

  suite "Reduced Row Echelon":
    test "Example 1":
      check TestMatrices[0].isReducedRowEchelon() == Expected[0]
    test "Example 2":
      check TestMatrices[1].isReducedRowEchelon() == Expected[1]
    test "Example 3":
      check TestMatrices[2].isReducedRowEchelon() == Expected[2]
    test "Example 4":
      check TestMatrices[3].isReducedRowEchelon() == Expected[3]
    test "Example 5":
      check TestMatrices[4].isReducedRowEchelon() == Expected[4]
    test "Example 6":
      check TestMatrices[5].isReducedRowEchelon() == Expected[5]
