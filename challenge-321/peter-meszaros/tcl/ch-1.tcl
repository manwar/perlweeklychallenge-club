#!/usr/bin/env tclsh
#
# Task 1: Distinct Average
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of numbers with even length.
# 
# Write a script to return the count of distinct average. The average is
# calculate by removing the minimum and the maximum, then average of the two.
# 
# Example 1
# 
#     Input: @nums = (1, 2, 4, 3, 5, 6)
#     Output: 1
# 
#     Step 1: Min = 1, Max = 6, Avg = 3.5
#     Step 2: Min = 2, Max = 5, Avg = 3.5
#     Step 3: Min = 3, Max = 4, Avg = 3.5
# 
#     The count of distinct average is 1.
# 
# Example 2
# 
#     Input: @nums = (0, 2, 4, 8, 3, 5)
#     Output: 2
# 
#     Step 1: Min = 0, Max = 8, Avg = 4
#     Step 2: Min = 2, Max = 5, Avg = 3.5
#     Step 3: Min = 3, Max = 4, Avg = 3.5
# 
#     The count of distinct average is 2.
# 
# Example 3
# 
#     Input: @nums = (7, 3, 1, 0, 5, 9)
#     Output: 2
# 
#     Step 1: Min = 0, Max = 9, Avg = 4.5
#     Step 2: Min = 1, Max = 7, Avg = 4
#     Step 3: Min = 3, Max = 5, Avg = 4
# 
#     The count of distinct average is 2.
# 

package require tcltest

set cases {
    {{1 2 4 3 5 6} 1 {Example 1}}
    {{0 2 4 8 3 5} 2 {Example 2}}
    {{7 3 1 0 5 9} 2 {Example 3}}
}

proc distinct_average {nums} {
    set nums_sorted [lsort -integer -unique $nums]
    set avgs {}

    while {[llength $nums_sorted] > 1} {
        set min [lindex $nums_sorted 0]
        set max [lindex $nums_sorted end]
        set nums_sorted [lreplace $nums_sorted 0 0]
        set nums_sorted [lreplace $nums_sorted end end]

        set avg [expr ($min + $max) / 2.0]
        dict set avgs $avg 1
    }
    return [llength [dict keys $avgs]]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       distinct_average [lindex $case 0]
    } [lindex $case 1]
}

exit 0

