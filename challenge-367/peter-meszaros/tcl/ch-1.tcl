#!/usr/bin/env tclsh
#
# Task 1: Max Odd Binary
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a binary string that has at least one '1'.  Write a script to
# rearrange the bits in such a way that the resulting binary number is the
# maximum odd binary number and return the resulting binary string. The resulting
# string can have leading zeros.
# 
# Example 1
# 
#     Input: $str = "1011"
#     Output: "1101"
# 
#     "1101" is max odd binary (13).
# 
# Example 2
# 
#     Input: $str = "100"
#     Output: "001"
# 
#     "001" is max odd binary (1).
# 
# Example 3
# 
#     Input: $str = "111000"
#     Output: "110001"
# 
# Example 4
# 
#     Input: $str = "0101"
#     Output: "1001"
# 
# Example 5
# 
#     Input: $str = "1111"
#     Output: "1111"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {  "1011"   "1101" "Example 1"}
    {   "100"    "001" "Example 2"}
    {"111000" "110001" "Example 3"}
    {  "0101"   "1001" "Example 4"}
    {  "1111"   "1111" "Example 5"}
}

proc max_odd_binary {str} {

    set bits [lrange [lsort -decreasing -integer [split $str ""]] 1 end]
    lappend bits 1
    return [join $bits {}]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        max_odd_binary [lindex $case 0]
    } [lindex $case 1]
}

exit 0

