#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/strutils

proc alignTriangle(nums: openArray[int], padLine, padNum: int): string =
  result = ' '.repeat(padLine * (padNum div 2))
  for i, num in nums:
    if i == nums.high:
      result.add $num
    else:
      result.add alignLeft($num, padNum)
  result.add '\n'

proc pascalTriangle*(n: range[3..67] = 3): string =
  let padNum = if n > 33: 20 elif n > 20: 10 elif n > 10: 6 elif n > 5: 4 else: 2

  var row = @[1]
  for i in 2..n:
    let padLine = n - i + 1
    result.add row.alignTriangle(padLine, padNum)

    var next: seq[int]
    for j in 0 ..< i:
      if j == 0 or j == i-1:
        next.add 1
      else:
        next.add row[j-1] + row[j]

    row = next

  result.add row.alignTriangle(0, padNum)

when isMainModule:
  import std/[cmdline, rdstdin, options]

  var rows: Option[int]
  try:
    if paramCount() == 1:
      rows = some(parseInt paramStr(1))
    if rows.isNone():
      rows = some(parseInt readLineFromStdin("Enter number of rows [3-67]: "))
  except ValueError as err:
    quit err.msg

  if rows.get() notin 3..67:
    quit "Only signed 64-bit numbers are supported. Please enter a number between 3 and 67."

  echo pascalTriangle(rows.get())
