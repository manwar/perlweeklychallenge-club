#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/sequtils

proc encode(num: int, base: seq[char]): string =
  if num == 0: return "0"
  var num = num
  while num > 0:
    result.insert $base[num mod base.len]
    num = num div base.len

proc decode(num: string, base: seq[char]): int =
  for d in num:
    let v = base.find(d)
    result = result * base.len + v

const Base = toSeq('0'..'9') & toSeq( 'A'..'Y')
const Test = 123456789

echo Test, " == ", Test.encode(Base), " == ", Test.encode(Base).decode(Base)
