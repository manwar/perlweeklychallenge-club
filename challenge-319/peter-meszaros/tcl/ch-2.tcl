#!/usr/bin/env tclsh
#
# Task 2: Minimum Common
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two arrays of integers.
# 
# Write a script to return the minimum integer common to both arrays. If none
# found return -1.
# 
# Example 1
# 
#     Input: @array_1 = (1, 2, 3, 4)
#            @array_2 = (3, 4, 5, 6)
#     Output: 3
# 
#     The common integer in both arrays: 3, 4
#     The minimum is 3.
# 
# Example 2
# 
#     Input: @array_1 = (1, 2, 3)
#            @array_2 = (2, 4)
#     Output: 2
# 
# Example 3
# 
#     Input: @array_1 = (1, 2, 3, 4)
#            @array_2 = (5, 6, 7, 8)
#     Output: -1
# 

package require tcltest

set cases {
    {{{1 2 3 4} {3 4 5 6}}  3 {Example 1}}
    {{{1 2 3}   {2 4}}      2 {Example 2}}
    {{{1 2 3 4} {5 6 7 8}} -1 {Example 3}}
}

proc minimum_common {p} {
    set array1 [lindex $p 0]
    set array2 [lindex $p 1]

    foreach i $array1 {
        dict set hash1 $i 1
    }

    set sorted2 [lsort -integer $array2]

    foreach i $sorted2 {
        set v -1
        if {[dict exists $hash1 $i]} {
            set v [dict get $hash1 $i]
        } 
        set x [lappend x $v]
    }

    for {set i 0} {$i < [llength $x]} {incr i} {
        if {[lindex $x $i] == 1} {
            return [lindex $sorted2 $i]
        }
    }
    return -1
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       minimum_common [lindex $case 0]
    } [lindex $case 1]
}

exit 0

