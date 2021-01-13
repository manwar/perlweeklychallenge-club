#!/usr/bin/env tclsh

# Just like the perl version, store counts in a hash table and stop
# at the first over the cutoff.

proc task1 args {
    set cutoff [expr {floor([llength $args] / 2.0)}]
    foreach elem $args {
        dict incr counts $elem
        if {[dict get $counts $elem] > $cutoff} {
            puts $elem
            return
        }
    }
    puts -1
}

task1 1 2 2 3 2 4 2
task1 1 3 1 2 4 5
