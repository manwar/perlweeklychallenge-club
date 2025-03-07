#!/usr/bin/env tclsh
#
# Task 1: Upper Lower
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string consists of english letters only.
# 
# Write a script to convert lower case to upper and upper case to lower in the
# given string.
# 
# Example 1
# 
#     Input: $str = "pERl"
#     Output: "PerL"
# 
# Example 2
# 
#     Input: $str = "rakU"
#     Output: "RAKu"
# 
# Example 3
# 
#     Input: $str = "PyThOn"
#     Output: "pYtHoN"
# 

package require tcltest

set cases {
    {"pERl"   "PerL"   "Example 1"}
    {"rakU"   "RAKu"   "Example 2"}
    {"PyThOn" "pYtHoN" "Example 3"}
}

proc upper_lower {p} {
    set l [split $p ""]
    foreach c $l {
        if {[string is upper $c]} {
            append r [string tolower $c]
        } else {
            append r [string toupper $c]
        }
    }
    return $r
}

#
tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       upper_lower [lindex $case 0]
    } [lindex $case 1]
}

exit 0

