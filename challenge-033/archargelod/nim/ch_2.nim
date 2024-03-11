#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, strformat]

proc printMultiplicationTable(max: Positive) =
  # header
  stdout.write "  x|"
  for i in 1..max: stdout.write &"{i:4}"
  stdout.write '\n'
  echo "---+", '-'.repeat(max*4)
  # body
  for i in 1..max:
    stdout.write &"{i:3}|"
    for j in 1..max:
      if j < i:
        stdout.write ' '.repeat(4)
      else:
        stdout.write &"{i*j:4}"

    stdout.write '\n'

when isMainModule:
  printMultiplicationTable(11)
