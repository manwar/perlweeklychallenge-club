#!/usr/bin/env tclsh
#
# Task 1: Zero Friend
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of numbers.
# 
# Find the number that is closest to zero and return its distance to zero.
# 
# Example 1
# 
#     Input: @nums = (4, 2, -1, 3, -2)
#     Output: 1
# 
#     Values closest to 0: -1 and 2 (distance = 1 and 2)
# 
# Example 2
# 
#     Input: @nums = (-5, 5, -3, 3, -1, 1)
#     Output: 1
# 
#     Values closest to 0: -1 and 1 (distance = 1)
# 
# Example 3
# 
#     Input: @ums = (7, -3, 0, 2, -8)
#     Output: 0
# 
#     Values closest to 0: 0 (distance = 0)
#     Exact zero wins regardless of other close values.
# 
# Example 4
# 
#     Input: @nums = (-2, -5, -1, -8)
#     Output: 1
# 
#     Values closest to 0: -1 and -2 (distance = 1 and 2)
# 
# Example 5
# 
#     Input: @nums = (-2, 2, -4, 4, -1, 1)
#     Output: 1
# 
#     Values closest to 0: -1 and 1 (distance = 1)
# 

package require tcltest

set cases {
    {{ 4  2 -1  3 -2}   1 "Example 1"}
    {{-5  5 -3  3 -1 1} 1 "Example 2"}
    {{ 7 -3  0  2 -8}   0 "Example 3"}
    {{-2 -5 -1 -8}      1 "Example 4"}
    {{-2  2 -4  4 -1 1} 1 "Example 5"}
}

proc zero_friend {nums} {
    set min {}
    foreach n $nums {
        set abs [expr abs($n)]
        if {$min eq "" || $abs < $min} {
            set min $abs
        }
    }
    return $min
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        zero_friend [lindex $case 0]
    } [lindex $case 1]
}

exit 0

