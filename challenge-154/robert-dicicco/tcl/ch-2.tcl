# Author: Robert DiCicco
# Date: 1-MAR-2022
# Challenge #154 Padovan Prime ( Tcl )

proc primetest n {
  set max [expr wide(sqrt($n))]
  if {$n%2==0} {return 0}
      for {set i 3} {$i<=$max} {incr i 2} {
      if {$n%$i==0} {return 0}
  }

  return 1
}

set start { 1 1 1}
set len [llength $start]
set count 10

puts -nonewline "2 "

while { $count > 1 } {
  set first [lindex $start [ expr $len - 2]]
  set second [lindex $start [ expr $len - 3]]
  set val [expr $first + $second]
  set retval [primetest $val]

  if { ($retval == 1) } {
    puts -nonewline "$val "
    set count [ expr {$count - 1} ]
  }

  lappend start $val

  set len [llength $start]
}

puts " "
