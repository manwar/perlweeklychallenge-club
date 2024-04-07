#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc isStepping*(number: int): bool =
  let digits = $number
  for i, c in digits:
    if i == 0: continue
    if abs(c.ord - digits[i-1].ord) != 1:
      return false
  true


when isMainModule:
  echo "All Stepping Numbers between 100 and 999: "
  for i in 100..999:
    if i.isStepping():
      stdout.write i, ", "
