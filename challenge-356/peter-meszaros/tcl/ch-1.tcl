#!/usr/bin/env tclsh
#
# Task 1: Kolakoski Sequence
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an integer, $int > 3. Write a script to generate the Kolakoski
# Sequence of given length $int and return the count of 1 in the generated
# sequence. Please follow the wikipedia page for more informations.
# 
# Example 1
# 
#     Input: $int = 4
#     Output: 2
# 
#     (1)(22)(11)(2) => 1221
# 
# Example 2
# 
#     Input: $int = 5
#     Output: 3
# 
#     (1)(22)(11)(2)(1) => 12211
# 
# Example 3
# 
#     Input: $int = 6
#     Output: 3
# 
#     (1)(22)(11)(2)(1)(22) => 122112
# 
# Example 4
# 
#     Input: $int = 7
#     Output: 4
# 
#     (1)(22)(11)(2)(1)(22)(1) => 1221121
# 
# Example 5
# 
#     Input: $int = 8
#     Output: 4
# 
#     (1)(22)(11)(2)(1)(22)(1)(22) => 12211212
# 

package require Tcl 8.6
package require tcltest

set cases {
    {4 2 "Example 1"}
    {5 3 "Example 2"}
    {6 3 "Example 3"}
    {7 4 "Example 4"}
    {8 4 "Example 5"}
}

proc kolakoski_sequence {n} {
    set seq {1 2 2}
    set index 2
    while {[llength $seq] < $n} {
        set count [lindex $seq $index]
        incr index
        set next_value [expr [lindex $seq end] == 1 ? 2 : 1]
        for {set i 0} {$i < $count} {incr i} {
            if {[llength $seq] >= $n} {
                break
            }
            lappend seq $next_value
        }
    }
    set ones_count 0
    foreach val $seq {
        if {$val == 1} {
            incr ones_count
        }
    }
    return $ones_count
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        kolakoski_sequence [lindex $case 0]
    } [lindex $case 1]
}

exit 0

