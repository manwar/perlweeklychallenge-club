#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[tables, options]

type
  Node = ref object
    index: int
    data: int
    parent, child: Node

  LRU = object
    capacity: int
    head: Node
    tail: Node
    lookup: Table[int, Node]

proc `$`(n: Node): string =
  if n.isNil: "nil" else: $n.data

proc initLRU*(cap: Positive): LRU =
  result.capacity = cap
  result.lookup = initTable[int, Node](cap)

proc set*(cache: var LRU, ind, item: int) =
  if cache.lookup.len == 0:
    cache.head = Node(index: ind, data: item)
    cache.lookup[ind] = cache.head
    cache.tail = cache.head
    return

  if cache.lookup.len >= cache.capacity:
    if cache.tail.parent != nil:
      cache.lookup.del cache.tail.index
      cache.tail.parent.child = nil
      cache.tail = cache.tail.parent

  cache.head = Node(index: ind, data: item, child: cache.head)
  cache.head.child.parent = cache.head
  cache.lookup[ind] = cache.head

proc get*(cache: var LRU, ind: int): Option[int] =
  if cache.lookup.contains ind:
    var n = cache.lookup[ind]

    if n != cache.head:
      if n == cache.tail:
        n.parent.child = nil
        cache.tail = n.parent
      else:
        n.parent.child = n.child
        n.child.parent = n.parent

      n.parent = nil
      n.child = cache.head
      cache.head.parent = n
      cache.head = n

    some(n.data)
  else:
    none(int)

when isMainModule:
  import std/unittest

  suite "LRU Cache Tests":
    test "Setting and Retrieving Values":
      var cache = initLRU(2)
      cache.set(1, 100)
      cache.set(2, 200)
      check:
        cache.get(1).get == 100
        cache.get(2).get == 200

    test "Promotion":
      var cache = initLRU(2)
      cache.set(1, 100)
      cache.set(2, 200)
      discard cache.get(1)
      check:
        cache.head.data == 100
        cache.tail.data == 200

    test "Cache Eviction":
      var cache = initLRU(2)
      cache.set(1, 100)
      cache.set(2, 200)
      cache.set(3, 300)
      check:
        cache.get(1).isNone
        cache.get(2).get == 200
        cache.get(3).get == 300
