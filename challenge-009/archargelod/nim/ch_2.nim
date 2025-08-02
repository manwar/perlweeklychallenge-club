#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[algorithm]

type
  IndexedItems[T] = seq[tuple[val: T, idx: int]]
  TieStrategy = enum
    Standard
    Modified
    Dense

proc standardRanking(items: sink IndexedItems): seq[int] =
  result = newSeq[int](items.len)
  var currentRank = 1
  for i, (item, idx) in items:
    if i > 0 and items[i - 1].val < item:
      currentRank = i + 1
    result[idx] = currentRank

proc modifiedRanking(items: sink IndexedItems): seq[int] =
  result = newSeq[int](items.len)
  var currentRank = items.len
  for i in countDown(items.high, 0):
    let (item, idx) = items[i]
    if i < items.high and items[i + 1].val > item:
      currentRank = i + 1
    result[idx] = currentRank

proc denseRanking(items: sink IndexedItems): seq[int] =
  result = newSeq[int](items.len)
  var currentRank = 1
  for i, (item, idx) in items:
    if i > 0 and items[i - 1].val < item:
      inc currentRank
    result[idx] = currentRank

proc rank*[T](items: openArray[T], strategy: TieStrategy = Standard): seq[int] =
  var indexedItems = newSeq[tuple[val: T, idx: int]](items.len)
  for idx, val in items:
    indexedItems[idx] = (val, idx)

  indexedItems.sort()

  case strategy
  of Standard:
    standardRanking(indexedItems)
  of Modified:
    modifiedRanking(indexedItems)
  of Dense:
    denseRanking(indexedItems)

when isMainModule:
  import std/unittest
  suite "Standard/modified/dense ranking":
    test "standard ranking":
      check [0, 4, 4, 5].rank(Standard) == [1, 2, 2, 4]
    test "modified ranking":
      check [0, 4, 4, 5].rank(Modified) == [1, 3, 3, 4]
    test "dense ranking":
      check [0, 4, 4, 5].rank(Dense) == [1, 2, 2, 3]
