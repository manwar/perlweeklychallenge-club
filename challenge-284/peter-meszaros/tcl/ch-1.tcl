#!/usr/bin/env tclsh
#
# Task 1: Lucky Integer
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# 
# Write a script to find the lucky integer if found otherwise return -1. If there
# are more than one then return the largest.
# 
# 	A lucky integer is an integer that has a frequency in the array equal to
# 	its value.
# 
# Example 1
# 
# 	Input: @ints = (2, 2, 3, 4)
# 	Output: 2
# 
# Example 2
# 
# 	Input: @ints = (1, 2, 2, 3, 3, 3)
# 	Output: 3
# 
# Example 3
# 
# 	Input: @ints = (1, 1, 1, 3)
# 	Output: -1
# 

package require tcltest

set cases {
	{{2 2 3 4}     2  "Example 1"}
	{{1 2 2 3 3 3} 3  "Example 2"}
	{{1 1 1 3}    -1  "Example 3"}
}

proc lucky_integer {ints} {

    set d {}
    foreach i $ints {
        dict incr d $i
    }

    foreach i [lsort -integer -decreasing [dict key $d]] {
        if {$i == [dict get $d $i]} {
            return $i 
        }
    }
	return -1
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        lucky_integer [lindex $case 0]
    } [lindex $case 1]
}

exit 0
