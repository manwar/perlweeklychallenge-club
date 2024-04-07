#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/tables

type
  ItemGroup = tuple[id, count: int]
  ItemCollection = seq[ItemGroup]

proc merge*(collection1, collection2: openArray[ItemGroup]): ItemCollection =
  var collected: OrderedTable[int, int]

  for items in [collection1, collection2]:
    for item in items:
      if collected.hasKeyOrPut(item.id, item.count):
        collected[item.id] += item.count

  for key, val in collected:
    result.add (key, val)

when isMainModule:
  import std/unittest

  const
    Test = [
      (@[(1,1), (2,1), (3,2)], @[(2,2), (1,3)]),
      (@[(1,2), (2,3), (1,3), (3,2)], @[(3,1), (1,3)]),
      (@[(1,1), (2,2), (3,3)], @[(2,3), (2,4)]),
    ]
    Expected = [
      @[(1, 4), (2, 3), (3, 2)],
      @[(1, 8), (2, 3), (3, 3)],
      @[(1, 1), (2, 9), (3, 3)],
    ]

  suite "Merge Items":
    test "Example 1":
      check merge(Test[0][0], Test[0][1]) == Expected[0]
    test "Example 2":
      check merge(Test[1][0], Test[1][1]) == Expected[1]
    test "Example 2":
      check merge(Test[2][0], Test[2][1]) == Expected[2]

