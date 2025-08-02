#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
## Anyone could implement a formula, so here is a
## bruteforce approach of trying every combination of digits
## which sum is equal to the base and checking if number is self-descriptive.
## It's very slow past base 12.
import std/[sequtils, strutils, bitops, math, sugar]

type Number = object
  data: seq[int]

proc `$`(number: Number): string =
  const digits = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  var digitSeq: seq[char]
  for i in countDown(number.data.high, 0):
    digitSeq.insert(digits[number.data[i]])
  digitSeq.join()

iterator combinations(fullSet: openarray[int], n: int): seq[int] =
  for i in 1..2^fullSet.len:
    if i.countSetBits() != n: continue

    var buf = newSeqOfCap[int](n)
    for j in 0..fullSet.high:
      if i.testBit(j):
        buf.add fullSet[j]

    yield buf

iterator groupCombinations(n, m: int): seq[int] =
  for c in combinations(toSeq(0..<n+m-1), m-1):
    let res = collect:
      for s in zip(@[-1] & c, c & @[n + m - 1]):
        s[1] - s[0] - 1
    yield res

proc isSelfDescriptive(number: Number): bool =
  for i, val in number.data:
    if number.data.count(i) != val:
      return false
  true

when isMainModule:
  const bases = [4,5,7,8,9,10,11,12]

  for base in bases:
    for comb in groupCombinations(base, base):
      if comb.anyIt(it >= base): continue
      let number = Number(data: comb)
      if number.isSelfDescriptive():
        echo base, ": ", number
        break
