#!/usr/bin/env tclsh
#
# Task 2: Special Binary Substrings
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a binary string.  Write a script to return all non-empty
# substrings (distinct) that have the same number of 0's and 1's, and all the 0's
# and all the 1's in these substrings are grouped consecutively.
# 
# Example 1
# 
#     Input: $binary = "0101"
#     Output: ("01", "10")
# 
# Example 2
# 
#     Input: $binary = "000111"
#     Output: ("000111", "0011", "01")
# 
# Example 3
# 
#     Input: $binary = "000011"
#     Output:  ("0011", "01")
# 
# Example 4
# 
#     Input: $binary = "10011100"
#     Output: ("10", "0011", "01", "1100")
# 
# Example 5
# 
#     Input: $binary = "00000"
#     Output: ()
# 


package require Tcl 8.6
package require tcltest

set cases {
    {0101     {01 10}           "Example 1"}
    {000111   {000111 0011 01}  "Example 2"}
    {000011   {0011 01}         "Example 3"}
    {10011100 {0011 01 10 1100} "Example 4"}
    {00000    {}                "Example 5"}
}

proc special_binary_substrings {binary} {
    set seen {}
    set len [string length $binary]

    for {set i 0} {$i < $len} {incr i} {
        for {set j [expr {$i + 2}]} {$j <= $len} {incr j} {
            set substr [string range $binary $i [expr {$j - 1}]]
            if {[dict exists $seen $substr]} {
                continue
            }
            set count_0 [string length [string map {"1" ""} $substr]]
            set count_1 [string length [string map {"0" ""} $substr]]
            if {$count_0 == $count_1 && ([regexp {^(0+1+|1+0+)$} $substr])} {
                dict set seen $substr 1
            }
        }
    }
    return [lsort [dict keys $seen]]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       special_binary_substrings [lindex $case 0]
    } [lindex $case 1]
}

exit 0

