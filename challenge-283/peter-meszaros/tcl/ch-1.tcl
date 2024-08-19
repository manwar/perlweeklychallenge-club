#!/usr/bin/env tclsh
#
# Task 1: Unique Number
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints, where every elements appears more
# than once except one element.
# 
# Write a script to find the one element that appears exactly one time.
# 
# Example 1
# 
# 	Input: @ints = (3, 3, 1)
# 	Output: 1
# 
# Example 2
# 
# 	Input: @ints = (3, 2, 4, 2, 4)
# 	Output: 3
# 
# Example 3
# 
# 	Input: @ints = (1)
# 	Output: 1
# 
# Example 4
# 
# 	Input: @ints = (4, 3, 1, 1, 1, 4)
# 	Output: 3
# 

package require tcltest

set cases {
    {{3 3 1}       1    "Example 1"}
    {{3 2 4 2 4}   3    "Example 2"}
    {{1}           1    "Example 3"}
    {{4 3 1 1 1 4} 3    "Example 4"}
	{{3 2 4 3 2 4} null "Example 5"}
}

proc unique_number {ints} {
    foreach i $ints {
        dict incr d $i
    }
    foreach k [dict keys $d] {
        if {[dict get $d $k] == 1} {
            return $k
        }
    }
    return null
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        unique_number [lindex $case 0]
    } [lindex $case 1]
}

exit 0
