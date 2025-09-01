#!/usr/bin/env tclsh
#
# Task 1: Smaller Than Current
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of numbers, @num1.
# 
# Write a script to return an array, @num2, where $num2[i] is the count of all
# numbers less than or equal to $num1[i].
# 
# Example 1
# 
#     Input: @num1 = (6, 5, 4, 8)
#     Output: (2, 1, 0, 3)
# 
#     index 0: numbers <= 6 are 5, 4    => 2
#     index 1: numbers <= 5 are 4       => 1
#     index 2: numbers <= 4, none       => 0
#     index 3: numbers <= 8 are 6, 5, 4 => 3
# 
# Example 2
# 
#     Input: @num1 = (7, 7, 7, 7)
#     Output: (3, 3, 3, 3)
# 
# Example 3
# 
#     Input: @num1 = (5, 4, 3, 2, 1)
#     Output: (4, 3, 2, 1, 0)
# 
# Example 4
# 
#     Input: @num1 = (-1, 0, 3, -2, 1)
#     Output: (1, 2, 4, 0, 3)
# 
# Example 5
# 
#     Input: @num1 = (0, 1, 1, 2, 0)
#     Output: (1, 3, 3, 4, 1)
# 

package require tcltest

set cases {
    {{ 6 5 4  8}   {2 1 0 3}   "Example 1"}
    {{ 7 7 7  7}   {3 3 3 3}   "Example 2"}
    {{ 5 4 3  2 1} {4 3 2 1 0} "Example 3"}
    {{-1 0 3 -2 1} {1 2 4 0 3} "Example 4"}
    {{ 0 1 1  2 0} {1 3 3 4 1} "Example 5"}
}

proc smaller_than_current {nums} {
    set result {}
    foreach i $nums {
        set count 0
        foreach j $nums {
            if {$j <= $i} {
                incr count
            }
        }
        lappend result [expr $count - 1]
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        smaller_than_current [lindex $case 0]
    } [lindex $case 1]
}

exit 0

