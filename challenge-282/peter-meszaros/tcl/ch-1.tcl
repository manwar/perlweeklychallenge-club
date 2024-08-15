#!/usr/bin/env tclsh
#
# Task 1: Good Integer
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a positive integer, $int, having 3 or more digits.
# 
# Write a script to return the Good Integer in the given integer or -1 if none
# found.
# 
#     A good integer is exactly three consecutive matching digits.
# 
# Example 1
# 
#     Input: $int = 12344456
#     Output: "444"
# 
# Example 2
# 
#     Input: $int = 1233334
#     Output: -1
# 
# Example 3
# 
#     Input: $int = 10020003
#     Output: "000"
# 

package require tcltest

set cases {
    {12344456   444 "Example 1"}
    {1233334     -1 "Example 2"}
    {10020003   000 "Example 3"}
    {1233334555 555 "Example 4"}
}

proc good_integer {str} {
    set l [expr [string length $str] - 3]
    for {set i 0} {$i <= $l} {incr i} {
        set s0 [string index $str $i]
        set s1 [string index $str [expr $i + 1]]
        set s2 [string index $str [expr $i + 2]]
        if {$s0 == $s1 && $s0 == $s2} {
            if {$i > 0} {
                if {[string index $str [expr $i - 1]] == $s0} {
                    continue
                }
            }
            if {$i < $l} {
                if {[string index $str [expr $i + 3]] == $s0} {
                    continue
                }
            }
            return "$s0$s0$s0"
        }
    }
    return -1
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        good_integer [lindex $case 0]
    } [lindex $case 1]
}

exit 0

