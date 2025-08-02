#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/math

proc toBase(dec, base: int): string =
  var dec = dec
  while dec > 0:
    var rem = 0
    (dec, rem) = divmod(dec, base)
    result.insert($rem, 0)

when isMainModule:
  for i in 0..50:
    echo "Decimal ", i, " = Octal ", i.toBase(8)

