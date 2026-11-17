#!/usr/bin/env tclsh
#
# Task 1: Largest Interval
# 
# Submitted by: Ali Moradi
# 
# You are given a positive integer.  Write a script that generates a sequence of
# integers from 1 to given positive integer, filtering out any numbers that
# contain repeating digits (e.g., 11, 99, 100, and 101 are excluded) and return
# the biggest jump.
# 
# Example 1
# 
#     Input: $int = 20
#     Output: 2
# 
#     Biggest jump between 10 and 12.
# 
# Example 2
# 
#     Input: $int = 110
#     Output: 4
# 
#     Biggest jump between 98 and 102.
# 
# Example 3
# 
#     Input: $int = 500
#     Output: 11
# 
#     Biggest jump between:
#     a) 109 and 120 => 11
#     b) 219 and 230 => 11
#     c) 329 and 340 => 11
#     d) 439 and 450 => 11
# 
# Example 4
# 
#     Input: $int = 2026
#     Output: 105
# 
#     Biggest jump between 1098 and 1203.
# 
# Example 5
# 
#     Input: $int = 10000
#     Output: 105
# 
#     The largest gap is 105, between 1098 and 1203. And again between 8796 and 8901.
# 

package require Tcl 8.6
package require tcltest

set cases {
    {   20   2 "Example 1"} 
    {  110   4 "Example 2"}
    {  500  11 "Example 3"}
    { 2026 105 "Example 4"}
    {10000 105 "Example 5"}
}

proc largest_interval {int} {
    set prev 0
    set max  0

    for {set n 1} {$n <= $int} {incr n} {
        if {![regexp {([0-9]).*\1} $n]} {
            set diff [expr $n - $prev]
            if {$diff > $max} {
                set max $diff
            }
            set prev $n
        }
    }
    return $max
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        largest_interval [lindex $case 0]
    } [lindex $case 1]
}

exit 0

