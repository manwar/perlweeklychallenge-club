# AUTHOR: Robert DiCicco
# DATE: 15-MAR-2022
# Challenge 156 Weird Numbers ( Tcl )

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

proc ladd l {                     ;# return sum of divisor subset

  if {![llength $l]} {return 0}
  return [expr [join $l +]]

}

set mynum [ lindex $argv 0 ]    ;# get number from the comman line
set flist [ math::numtheory::factors $mynum ]     ;# get list of divisors

set len [llength $flist]
set len [ expr { $len - 1 } ]

set mylist [lreplace $flist $len $len]            ;# drop the largest divisor

# step through all combinations of divisors and check sums

for { set cnt 2 } { $cnt < [llength $mylist] } { incr cnt } {

  set myval [combinations $mylist $cnt]

  foreach x $myval {
    set digsum [ ladd $x ]

    if { $digsum == $mynum } {      ;# found a subset with matching sum
      puts "Divisors: $mylist"
      puts "Subset: $x"
      puts "Input: n = $mynum"
      puts "Output: 0"

      exit
    }
  }
}

puts "Divisors: $mylist"            ;# else, drop through, not found
puts "Output: 1"
puts "No subset sums to $mynum"
