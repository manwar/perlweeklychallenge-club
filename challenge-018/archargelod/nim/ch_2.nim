#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
type
  PriorityQueue*[T] = object
    data: seq[tuple [item: T, priority: Natural]]

proc isEmpty*(q: PriorityQueue): bool =
  q.data.len == 0

proc add*[T](q: var PriorityQueue[T], item: sink T, priority: Natural = 0) =
  ## add item to the queue with specified priority
  ## 0 is max priority, 1 is less priority than 0 and so on
  proc findBestPos(data: seq[tuple [item: T, priority: Natural]], priority: int): int =
    # binary search
    var
      pivot = data.len div 2
      left = 0
      right = data.high

    while right - left > 1:
      if priority < data[pivot].priority:
        left = pivot
      else:
        right = pivot
      pivot = left + (right - left) div 2

    right

  if q.isEmpty or priority <= q.data[^1].priority:
    q.data.add (item, priority)
  elif priority > q.data[0].priority:
    q.data.insert((item, priority), 0)
  else:
    var pos = q.data.findBestPos(priority)
    q.data.insert((item, priority), pos)

proc pop*[T](q: var PriorityQueue[T]): T =
  ## remove the item with minimum priority value from the queue
  ## and return it
  if q.isEmpty:
    raise newException(ValueError, "can't pop value; the queue is empty")
  q.data.pop().item

when isMainModule:
  import std/unittest

  const
    Test = [
      ("World", 20),
      (",", 5),
      ("!", 1000),
      ("Hello", 0),
      (" ", 10),
    ]
    Expected = "Hello, World!"

  suite "Priority Queue":
    test "Hello world ordered with priority": 
      var queue: PriorityQueue[string]
      var res = newStringOfCap(Expected.len)
      for (word, prio) in Test:
        queue.add(word, prio)

      while not queue.isEmpty:
        res &= queue.pop()

      check res == Expected
