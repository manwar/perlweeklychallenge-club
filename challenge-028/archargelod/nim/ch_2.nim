#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[times, strutils]

const
  Dg_On = "•"
  Dg_Off = "·"

proc displayBinaryClock*() =
  var columns: array[6, array[4, bool]]

  for colId, decDigit in format(now(), "HHmmss"):
    for bitId, bit in (decDigit.ord - '0'.ord).toBin(4):
      if bit == '1':
        columns[colId][bitId] = true

  for y in columns[0].low .. columns[0].high:
    for x in columns.low .. columns.high:
      stdout.write if columns[x][y]: Dg_On else: Dg_Off
    stdout.write '\n'
  stdout.flushFile()

when isMainModule:
  displayBinaryClock()
