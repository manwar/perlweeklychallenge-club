import std/[algorithm, unittest]

# run tests with following command:
# nim c -r ch_1.nim

type
  MinMaxKind = enum
    mmInt,
    mmSeq
  MinMax = object
    case kind: MinMaxKind
    of mmInt: intVal: int
    of mmSeq: seqVal: seq[int]

proc min_max(a: openArray[int]): MinMax =
  if len(a) < 3:
    return MinMax(kind: mmInt, intVal: -1)

  var
    sa: seq[int] = sorted(a)
  result = MinMax(kind: mmSeq, seqVal: sa[1..^2])

suite "min-max":
  test "(3, 2, 1, 4)":
    var
      ints = @[3, 2, 1, 4]
    let
      x = min_max(ints)
      y = MinMax(kind: mmSeq, seqVal: @[2, 3])

    check(x.kind == y.kind)
    check(x.seqVal == y.seqVal)

  test "(3, 1)":
    var
      ints = @[3, 1]
    let
      x = min_max(ints)
      y = MinMax(kind: mmInt, intVal: -1)

    check(x.kind == y.kind)
    check(x.intVal == y.intVal)

  test "(2, 1, 3)":
    var
      ints = @[2, 1, 3]
    let
      x = min_max(ints)
      y = MinMax(kind: mmSeq, seqVal: @[2])

    check(x.seqVal == y.seqVal)
    check(x.kind == y.kind)
