#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/tables

var Procedures = {
  "-h": func(): int = 0,
  "-g": func(): int = 1,
}.toTable

proc dispatch(s: string): int =
  Procedures[s]()

when isMainModule:
  import std/[unittest, random]

  const
    Test = ["-h", "-g"]
    Expected = [1, 0]

  suite "Dispatch table":
    test "Execute function from table at runtime":
      check dispatch(Test[rand(1)]) == Expected[0]
    test "Execute different function from table at runtime":
      check dispatch(Test[rand(1)]) == Expected[1]

