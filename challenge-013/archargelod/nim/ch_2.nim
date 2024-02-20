#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/tables

type MethodKind = enum
  M
  F

proc m(n: Natural, memo: var Table[(MethodKind, int), int]): int

proc f(n: Natural, memo: var Table[(MethodKind, int), int]): int =
  if (F, n) in memo:
    return memo[(F, n)]

  result =
    if n == 0:
      1
    else:
      n - m(f(n - 1, memo), memo)

  memo[(F, n)] = result

proc m(n: Natural, memo: var Table[(MethodKind, int), int]): int =
  if (M, n) in memo:
    return memo[(M, n)]

  result =
    if n == 0:
      0
    else:
      n - f(m(n - 1, memo), memo)

  memo[(M, n)] = result

when isMainModule:
  import std/[sugar, unittest]

  const
    Count = 20
    ExpectedM = [0, 0, 1, 2, 2, 3, 4, 4, 5, 6, 6, 7, 7, 8, 9, 9, 10, 11, 11, 12]
    ExpectedF = [1, 1, 2, 2, 3, 3, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 11, 11, 12]

  suite "Mutually Recursive methods":
    var memo: Table[(MethodKind, int), int]

    test "First 20 Terms of F()":
      check:
        collect(
          for i in 0 ..< Count:
            f(i, memo)
        ) == ExpectedF

    test "First 20 Terms of M()":
      check:
        collect(
          for i in 0 ..< Count:
            m(i, memo)
        ) == ExpectedM
