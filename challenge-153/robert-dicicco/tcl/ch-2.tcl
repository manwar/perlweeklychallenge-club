# Author: Robert DiCicco
# Date:   22-FEB-2022
# Challenge # 153 Factorions (Tcl)

proc Factorial {x} {
  set i 1; set product 1
  while {$i <= $x } {
     set product [expr $product * $i]
     incr i
  }

  return $product
}

set i [lindex $argv 0 ]
set digits [split $i {}]
set finalsum 0

puts "Input: $i"

foreach num $digits {
  set X [Factorial $num]
  puts -nonewline "$num! +  "
  set finalsum [ expr $finalsum + $X ]
}

puts "\b\b\b = $finalsum"

if {$i == $finalsum} {
  puts "Output: 1"
} else {
  puts "Output: 0"
}
