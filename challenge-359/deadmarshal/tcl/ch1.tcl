#!/usr/bin/env tclsh

proc digitalRoot {n} {
  set pers 0
  set curr $n
  while {$curr > 9} {
    set sum 0
    foreach digit [split $curr ""] {
      incr sum $digit
    }
    set curr $sum
    incr pers
  }
  return "$pers $curr"
}

set nums {38 7 999 1999999999 101010}

foreach n $nums {
  foreach {pers root} [digitalRoot $n] break
  puts [format "Persistence  = %d\nDigital Root = %d" $pers $root]
}

