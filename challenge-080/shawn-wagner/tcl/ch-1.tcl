#!/usr/bin/env tclsh

# Perl one used hashes, so let's take a different approach in the tcl
# solution; a sorted list.

proc task1 args {
    set N [lsort -integer [lmap n $args { if {$n <= 0} { continue }; set n }]]
    set i 1
    set n 0
    set len [llength $N]
    while {$n < $len && $i == [lindex $N $n]} {
        incr n
        incr i
    }
    puts $i;
}

task1 5 2 -2 0
task1 1 8 -1
task1 2 0 -1
