#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/math

proc main =
  ## open room numbers are all perfect squares
  ## because room number stays open if it has odd number of positive divisors
  ## and that is only true for perfect square numbers
  for i in 1..500:
    if (let root = sqrt(float i); root) == trunc(root):
      echo i, " is open"


type
  DoorState = enum
    Open
    Closed

proc main2 =
  ## bruteforce approach
  var rooms: array[1..500, DoorState]

  template toggle(state: var DoorState) =
    case state
    of Open:
      state = Closed
    of Closed:
      state = Open

  for i in 2..500:
    for j in countUp(i, rooms.high, i):
      rooms[j].toggle()

  for i, room in rooms:
    if room == Open: echo i, " is open"

when isMainModule:
  main()
  #main2()
