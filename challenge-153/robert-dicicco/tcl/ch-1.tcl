# Author: Robert DiCicco
# Date:   21-FEB-2022
# Challenge #153 Left Factorials ( Tcl )

proc Factorial {x} {
   set i 1; set product 1
   while {$i <= $x} {
      set product [expr $product * $i]
      incr i
   }

   return $product
}

set Total 0
set I 0

while { $I < 10 } {
  set X [Factorial $I]
  set Total [expr $X + $Total]
  puts -nonewline $Total
  puts -nonewline " "
  incr I
}
