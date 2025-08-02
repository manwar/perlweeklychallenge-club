#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, sequtils, math]

type Box = object
  label: string
  weight, amount: int

proc `$`*(b: Box): string =
  b.label

proc allSubsets[T](baseSet: openarray[T]): seq[seq[T]] =
  for i in 1 ..< 2 ^ baseSet.len:
    let pattern = i.toBin(baseSet.len)
    result.add @[]
    for j, bit in pattern:
      if bit == '1':
        result[^1].add baseSet[j]

proc bestCombinations*(boxes: openarray[Box], maxWeight, maxBoxes: int): seq[seq[Box]] =
  var bestValue: int

  let subsetsB = boxes.toOpenArray(boxes.len div 2 + 1, boxes.high).allSubsets()
  for subsetA in boxes.toOpenArray(0, boxes.len div 2).allSubsets():
    let weightA = subsetA.mapIt(it.weight).sum()
    let valueA = subsetA.mapIt(it.amount).sum()

    for subsetB in subsetsB:
      let combinedWeight = weightA + subsetB.mapIt(it.weight).sum()
      let combinedValue = valueA + subsetB.mapIt(it.amount).sum()
      if (subsetA.len + subsetB.len) <= maxBoxes and combinedWeight <= maxWeight:
        if combinedValue > bestValue:
          bestValue = combinedValue
          result = @[subsetA & subsetB]
        elif combinedValue == bestValue:
          result.add subsetA & subsetB

when isMainModule:
  import std/unittest

  const
    Boxes = [
      Box(label: "R", weight: 1, amount: 1),
      Box(label: "B", weight: 1, amount: 2),
      Box(label: "G", weight: 2, amount: 2),
      Box(label: "Y", weight: 12, amount: 4),
      Box(label: "P", weight: 4, amount: 10),
    ]
    Expected = ["@[@[R, B, G, P]]", "@[@[B, G, P]]", "@[@[G, P], @[B, P]]"]

  suite "Knapsack Problem 0-1":
    test "5 or less boxes":
      check $bestCombinations(Boxes, 15, 5) == Expected[0]
    test "3 or less boxes":
      check $bestCombinations(Boxes, 15, 3) == Expected[1]
    test "2 or less boxes":
      check $bestCombinations(Boxes, 15, 2) == Expected[2]
