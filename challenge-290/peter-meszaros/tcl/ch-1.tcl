#!/usr/bin/env tclsh
#
# Task 1: Double Exist
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# 
# Write a script to find if there exist two indices $i and $j such that:
# 
#     1) $i != $j
#     2) 0 <= ($i, $j) < scalar @ints
#     3) $ints[$i] == 2 * $ints[$j]
# 
# Example 1
# 
#     Input: @ints = (6, 2, 3, 3)
#     Output: true
# 
#     For $i = 0, $j = 2
#     $ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]
# 
# Example 2
# 
#     Input: @ints = (3, 1, 4, 13)
#     Output: false
# 
# Example 3
# 
#     Input: @ints = (2, 1, 4, 2)
#     Output: true
# 
#     For $i = 2, $j = 3
#     $ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]
# 

package require tcltest

set cases {
    {{6 2 3  3} 1 {Example 1}}
    {{3 1 4 13} 0 {Example 2}}
    {{2 1 4  2} 1 {Example 3}}
}

proc double_exists {nums} {

    set len [llength $nums]
    for {set i 0} {$i < $len} {incr i} {
        set v [lindex $nums $i]
        dict set d [expr $v * 2] $v
    }

    for {set i 0} {$i < $len} {incr i} {
        set v [lindex $nums $i]
        if {[dict exists $d $v] == 1 && [dict get $d $v] != $i} {
            return 1
        }
    }
    return 0
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       double_exists [lindex $case 0]
    } [lindex $case 1]
}

exit 0

