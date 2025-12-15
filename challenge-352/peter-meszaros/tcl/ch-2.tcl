#!/usr/bin/env tclsh
#
# Task 2: Binary Prefix
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array, @nums, where each element is either 0 or 1.
# 
# Define xi as the number formed by taking the first i+1 bits of @nums (from
# $nums[0] to $nums[i]) and interpreting them as a binary number, with $nums[0]
# being the most significant bit.
# 
# For example:
# 
#     If @nums = (1, 0, 1), then:
# 
#     x0 = 1 (binary 1)
#     x1 = 2 (binary 10)
#     x2 = 5 (binary 101)
# 
#     For each i, check whether xi is divisible by 5.
# 
# Write a script to return an array @answer where $answer[i] is true if
# xi is divisible by 5, otherwise false.
# 
# Example 1
# 
#     Input: @nums = (0,1,1,0,0,1,0,1,1,1)
#     Output: (true, false, false, false, false, true, true, false, false, false)
# 
#     Binary numbers formed (decimal values):
#              0: 0
#             01: 1
#            011: 3
#           0110: 6
#          01100: 12
#         011001: 25
#        0110010: 50
#       01100101: 101
#      011001011: 203
#     0110010111: 407
# 
# Example 2
# 
#     Input: @num = (1,0,1,0,1,0)
#     Output: (false, false, true, true, false, false)
# 
#          1: 1
#         10: 2
#        101: 5
#       1010: 10
#      10101: 21
#     101010: 42
# 
# Example 3
# 
#     Input: @num = (0,0,1,0,1)
#     Output: (true, true, false, false, true)
# 
#         0: 0
#        00: 0
#       001: 1
#      0010: 2
#     00101: 5
# 
# Example 4
# 
#     Input: @num = (1,1,1,1,1)
#     Output: (false, false, false, true, false)
# 
#         1: 1
#        11: 3
#       111: 7
#      1111: 15
#     11111: 31
# 
# Example 5
# 
#     Input: @num = (1,0,1,1,0,1,0,0,1,1)
#     Output: (false, false, true, false, false, true, true, true, false, false)
# 
#              1: 1
#             10: 2
#            101: 5
#           1011: 11
#          10110: 22
#         101101: 45
#        1011010: 90
#       10110100: 180
#      101101001: 361
#     1011010011: 723
# 

package require Tcl 8.6
package require tcltest

set cases {
  {{0 1 1 0 0 1 0 1 1 1} 
    {true false false false false true true false false false} "Example 1"} 
  {{1 0 1 0 1 0} 
    {false false true true false false}                        "Example 2"} 
  {{0 0 1 0 1} 
    {true true false false true}                               "Example 3"} 
  {{1 1 1 1 1} 
    {false false false true false}                             "Example 4"} 
  {{1 0 1 1 0 1 0 0 1 1} 
    {false false true false false true true true false false}  "Example 5"} 
}

proc binary_prefix {nums} {
    set answer {}
    set value 0

    foreach bit $nums {
        set value [expr ($value << 1) | $bit]
        if {($value % 5) == 0} {
            lappend answer true
        } else {
            lappend answer false
        }
    }
    return $answer
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        binary_prefix [lindex $case 0]
    } [lindex $case 1]
}

exit 0

