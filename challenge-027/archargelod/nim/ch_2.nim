#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
type Hist*[T] = object
  # object fields without `*` are private and can't be accesed
  h_val: T
  h_history: seq[T]

func initHist*[T](value: T): Hist[T] =
  Hist[T](h_val: value)

func `history`*[T](obj: Hist[T]): seq[T] =
  ## getter for previous values of a historical type
  obj.h_history

func `val`*[T](obj: Hist[T]): T =
  ## getter for current value of a historical type
  obj.h_val

func `val=`*[T](obj: var Hist[T], value: T) =
  ## setter for value of a historical type
  if obj.h_val != value:
    obj.h_history.add obj.h_val
    obj.h_val = value

func `clearHistory`*[T](obj: var Hist[T]) =
  ## clear previous values of a historical type
  obj.h_history.setLen(0)

func `$`*[T](obj: Hist[T]): string =
  $obj.h_val

when isMainModule:
  import std/unittest

  suite "Historical values":
    test "basic example":
      var x = initHist[int](10)
      x.val = 20
      x.val = x.val - 5

      check x.val == 15
      check x.history == [10, 20]

    test "history doesn't change if value didn't change":
      var x = initHist[int](69)
      x.val = 69
      x.val = 420
      x.val = 420

      check x.val == 420
      check x.history == [69]

    test "clearHistory clears the history":
      var x = initHist[int](42)
      x.val = x.val + 1
      x.clearHistory()
      x.val = 133

      check x.val == 133
      check x.history == [43]
