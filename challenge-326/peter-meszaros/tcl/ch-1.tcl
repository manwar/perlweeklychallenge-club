#!/usr/bin/env tclsh
#
# Task 1: Day of the Year
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a date in the format YYYY-MM-DD.
# 
# Write a script to find day number of the year that the given date represent.
# 
# Example 1
# 
#     Input: $date = '2025-02-02'
#     Output: 33
# 
#     The 2nd Feb, 2025 is the 33rd day of the year.
# 
# Example 2
# 
#     Input: $date = '2025-04-10'
#     Output: 100
# 
# Example 3
# 
#     Input: $date = '2025-09-07'
#     Output: 250
# 

package require tcltest

set cases {
    {"2025-02-02"  33 "Example 1"}
    {"2025-04-10" 100 "Example 2"}
    {"2025-09-07" 250 "Example 3"}
}

proc day_of_the_year {y} {
    return [scan [clock format [clock scan $y] -format %j] %d]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       day_of_the_year [lindex $case 0]
    } [lindex $case 1]
}

exit 0

