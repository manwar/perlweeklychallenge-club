#!/usr/bin/env tclsh
set comment {
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-15
Challenge 234 Task 2 Unequal Triplets ( Tcl )
-----------------------------------
}

set myints {{4 4 2 4 3} {1 1 1 1 1} {4 7 1 10 7 4 1 1}}

package require math::numtheory

proc combinations { list size } {   ;# generate all combinations for supplied list of divisors
  if { $size == 0 } {
      return [list [list]]
  }
  set retval {}
  for { set i 0 } { ($i + $size) <= [llength $list] } { incr i } {
      set firstElement [lindex $list $i]
      set remainingElements [lrange $list [expr { $i + 1 }] end]
      foreach subset [combinations $remainingElements [expr { $size - 1 }]] {
          lappend retval [linsert $subset 0 $firstElement]
      }
  }
  return $retval
}

foreach mints $myints {
    puts "Input: @ints = ($mints)"
    set cnt 0
    set myval [combinations $mints 3]
    foreach num $myval {
        set mynum0 [ lindex $num 0 ]
        set mynum1 [ lindex $num 1 ]
        set mynum2 [ lindex $num 2 ]
        if { $mynum0 ne $mynum1 && $mynum1 ne $mynum2 && $mynum0 ne $mynum2 } {
                set cnt [expr $cnt + 1]
        }
    }
    puts "Output: $cnt\n"
}

set sample {
-----------------------------------
SAMPLE OUTPUT
tclsh .\UnequalTriplets.tcl

Input: @ints = (4 4 2 4 3)
Output: 3

Input: @ints = (1 1 1 1 1)
Output: 0

Input: @ints = (4 7 1 10 7 4 1 1)
Output: 28
-----------------------------------
}


