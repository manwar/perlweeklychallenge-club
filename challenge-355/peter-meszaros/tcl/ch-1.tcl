#!/usr/bin/env tclsh
#
# Task 1: Thousand Separator
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a positive integer, $int.
# Write a script to add thousand separator, , and return as string.
# 
# Example 1
# 
#     Input: $int = 123
#     Output: "123"
# 
# Example 2
# 
#     Input: $int = 1234
#     Output: "1,234"
# 
# Example 3
# 
#     Input: $int = 1000000
#     Output: "1,000,000"
# 
# Example 4
# 
#     Input: $int = 1
#     Output: "1"
# 
# Example 5
# 
#     Input: $int = 12345
#     Output: "12,345"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {    123       "123" "Example 1"}
    {   1234     "1,234" "Example 2"}
    {1000000 "1,000,000" "Example 3"}
    {      1         "1" "Example 4"}
    {  12345    "12,345" "Example 5"}
}

proc thousand_separator {int} {
    set str [string reverse [format "%d" $int]]
    regsub -all {(\d{3})(?=\d)} $str {\1,} str
    return [string reverse $str]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        thousand_separator [lindex $case 0]
    } [lindex $case 1]
}

exit 0

