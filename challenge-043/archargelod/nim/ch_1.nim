#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[sequtils, options, algorithm, sugar]

type
  Number = ref object
    value: Option[int]
  Ring = object
    color: string
    numbers: seq[Number]

proc sum(s: Ring): int =
  for n in s.numbers:
    if n.value.isSome():
      result += n.value.get()

proc main =
  var numbers = [
    Number(value: some(9)),
    Number(value: none(int)),
    Number(value: some(5)),
    Number(value: none(int)),
    Number(value: none(int)),
    Number(value: none(int)),
    Number(value: some(7)),
    Number(value: none(int)),
    Number(value: some(8)),
  ]

  var rings = [
    Ring(color: "red", numbers: @[numbers[0], numbers[1]]),
    Ring(color: "green", numbers: @[numbers[1], numbers[2], numbers[3]]),
    Ring(color: "black", numbers: @[numbers[3], numbers[4], numbers[5]]),
    Ring(color: "yellow", numbers: @[numbers[5], numbers[6], numbers[7]]),
    Ring(color: "purple", numbers: @[numbers[7], numbers[8]]),
  ]

  var empty = collect:
    for n in numbers:
      if n.value.isNone(): n

  var givenNums = [1,2,3,4,6]
  while not rings.allIt(it.sum() == 11):
    for i, n in givenNums:
      empty[i].value = some(n)
    givenNums.nextPermutation()

  for ring in rings:
    echo ring.color, ": ", ring.numbers.mapIt(it.value.get())

when isMainModule:
  main()
