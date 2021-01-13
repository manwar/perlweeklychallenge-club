#!/usr/bin/env tclsh

# Same approach as the perl solution

proc task2 args {
    set candies [llength $args]
    set len $candies
    for {set n 0} {$n < $len} {incr n} {
        if {($n > 0 && [lindex $args $n] > [lindex $args $n-1]) ||
            ($n < $len - 1 && [lindex $args $n] > [lindex $args $n+1])} {
            incr candies
        }
    }
    puts $candies
}


task2 1 2 2
task2 1 4 3 2
