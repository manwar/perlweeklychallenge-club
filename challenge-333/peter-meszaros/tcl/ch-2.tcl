#!/usr/bin/env tclsh
#
# Task 2: Duplicate Zeros
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers.
# 
# Write a script to duplicate each occurrence of zero, shifting the remaining
# elements to the right. The elements beyond the length of the original array are
# not written.
# 
# Example 1
# 
#     Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
#     Output: (1, 0, 0, 2, 3, 0, 0, 4)
# 
#     Each zero is duplicated.
#     Elements beyond the original length (like 5 and last 0) are discarded.
# 
# Example 2
# 
#     Input: @ints = (1, 2, 3)
#     Output: (1, 2, 3)
# 
#     No zeros exist, so the array remains unchanged.
# 
# Example 3
# 
#     Input: @ints = (1, 2, 3, 0)
#     Output: (1, 2, 3, 0)
# 
# Example 4
# 
#     Input: @ints = (0, 0, 1, 2)
#     Output: (0, 0, 0, 0)
# 
# Example 5
# 
#     Input: @ints = (1, 2, 0, 3, 4)
#     Output: (1, 2, 0, 0, 3)
# 

package require tcltest

set cases {
    {{1 0 2 3 0 4 5 0} {1 0 0 2 3 0 0 4} "Example 1"}
    {{1 2 3}           {1 2 3}           "Example 2"}
    {{1 2 3 0}         {1 2 3 0}         "Example 3"}
    {{0 0 1 2}         {0 0 0 0}         "Example 4"}
    {{1 2 0 3 4}       {1 2 0 0 3}       "Example 5"}
}

proc duplicate_zeros {ints} {
    set length [llength $ints]
    set result {}
    
    for {set i 0} {$i < $length} {incr i} {
        if {[lindex $ints $i] == 0} {
            lappend result 0 0
        } else {
            lappend result [lindex $ints $i]
        }
        if {[llength $result] >= $length} {
            break
        }
    }
    
    return [lrange $result 0 [expr $length - 1]]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        duplicate_zeros [lindex $case 0]
    } [lindex $case 1]
}

exit 0

