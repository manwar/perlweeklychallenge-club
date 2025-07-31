#!/usr/bin/env tclsh
#
# Task 1: Binary Date
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a date in the format YYYY-MM-DD.
# 
# Write a script to convert it into binary date.
# 
# Example 1
# 
#     Input: $date = "2025-07-26"
#     Output: "11111101001-111-11010"
# 
# Example 2
# 
#     Input: $date = "2000-02-02"
#     Output: "11111010000-10-10"
# 
# Example 3
# 
#     Input: $date = "2024-12-31"
#     Output: "11111101000-1100-11111"
# 

package require tcltest

set cases {
    {"2025-07-26" "11111101001-111-11010"  "Example 1"}
    {"2000-02-02" "11111010000-10-10"      "Example 2"}
    {"2024-12-31" "11111101000-1100-11111" "Example 3"}
}

proc binary_date {date} {
    set bindate {}
    foreach part [split $date "-"] {
        lappend bindate [format "%b" $part]
    }
    return [join $bindate "-"]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        binary_date [lindex $case 0]
    } [lindex $case 1]
}

exit 0

