#!/usr/bin/env tclsh
#
# Task 2: Digit Count Value
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of positive integers, @ints.
# 
# Write a script to return true if for every index i in the range 0 <= i < size
# of array, the digit i occurs exactly the $ints[$i] times in the given array
# otherwise return false.
# 
# Example 1
# 
# 	Input: @ints = (1, 2, 1, 0)
# 	Ouput: true
# 
# 	$ints[0] = 1, the digit 0 occurs exactly 1 time.
# 	$ints[1] = 2, the digit 1 occurs exactly 2 times.
# 	$ints[2] = 1, the digit 2 occurs exactly 1 time.
# 	$ints[3] = 0, the digit 3 occurs 0 time.
# 
# Example 2
# 
# 	Input: @ints = (0, 3, 0)
# 	Ouput: false
# 
# 	$ints[0] = 0, the digit 0 occurs 2 times rather than 0 time.
# 	$ints[1] = 3, the digit 1 occurs 0 time rather than 3 times.
# 	$ints[2] = 0, the digit 2 occurs exactly 0 time.
# 

package require tcltest

set cases {
	{{1 2 1 0} 1 "Example 1"}
    {{0 3 0}   0 "Example 2"}
}

proc digit_count_value {ints} {
    foreach i $ints {
        dict incr d $i
    }
    set l [llength $ints]
    for {set i 0} {$i < $l} {incr i} {
        if {[dict keys $d $i] == $i} {
            set v [dict get $d $i]
        } else {
            set v 0
        }
        if {[lindex $ints $i] != $v} {
            return 0 
        }
    }
    return 1
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        digit_count_value [lindex $case 0]
    } [lindex $case 1]
}

exit 0
