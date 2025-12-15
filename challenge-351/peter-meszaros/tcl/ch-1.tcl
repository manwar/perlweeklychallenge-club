#!/usr/bin/env tclsh
#
# Task 1: Special Average
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers.
# 
# Write a script to return the average excluding the minimum and maximum of the
# given array.
# 
# Example 1
# 
#     Input: @ints = (8000, 5000, 6000, 2000, 3000, 7000)
#     Output: 5250
# 
#     Min: 2000
#     Max: 8000
#     Avg: (3000+5000+6000+7000)/4 = 21000/4 = 5250
# 
# Example 2
# 
#     Input: @ints = (100_000, 80_000, 110_000, 90_000)
#     Output: 95_000
# 
#     Min: 80_000
#     Max: 110_000
#     Avg: (100_000 + 90_000)/2 = 190_000/2 = 95_000
# 
# Example 3
# 
#     Input: @ints = (2500, 2500, 2500, 2500)
#     Output: 0
# 
#     Min: 2500
#     Max: 2500
#     Avg: 0
# 
# Example 4
# 
#     Input: @ints = (2000)
#     Output: 0
# 
#     Min: 2000
#     Max: 2000
#     Avg: 0
# 
# Example 5
# 
#     Input: @ints = (1000, 2000, 3000, 4000, 5000, 6000)
#     Output: 3500
# 
#     Min: 1000
#     Max: 6000
#     Avg: (2000 + 3000 + 4000 + 5000)/4 = 14000/4 = 3500
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{8000 5000 6000 2000 3000 7000}  5250.0 "Example 1"}
    {{100000 80000 110000 90000}     95000.0 "Example 2"}
    {{2500 2500 2500 2500}               0.0 "Example 3"}
    {{2000}                              0.0 "Example 4"}
    {{1000 2000 3000 4000 5000 6000}  3500.0 "Example 5"}
}

proc special_average {ints} {
    set min {}
    set max {}

    foreach i $ints {
        if {$min == {} || $i < $min} {
            set min $i
        }
        if {$max == {} || $i > $max} {
            set max $i
        }
    }

    set avg 0.0
    set cnt 0
    foreach i $ints {
        if {$i == $min || $i == $max} {
            continue
        }
        incr cnt
        set avg [expr $avg + ($i - $avg) / $cnt]
    }
    return $avg
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        special_average [lindex $case 0]
    } [lindex $case 1]
}

exit 0

