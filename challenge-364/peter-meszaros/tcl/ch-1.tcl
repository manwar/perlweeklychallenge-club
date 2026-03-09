#!/usr/bin/env tclsh
#
# Task 1: Decrypt String
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string formed by digits and '#'.
# Write a script to map the given string to English lowercase characters following the given rules.
# 
#     - Characters 'a' to 'i' are represented by '1' to '9' respectively.
#     - Characters 'j' to 'z' are represented by '10#' to '26#' respectively.
# 
# Example 1
# 
#     Input: $str = "10#11#12"
#     Output: "jkab"
# 
#     10# -> j
#     11# -> k
#     1   -> a
#     2   -> b
# 
# Example 2
# 
#     Input: $str = "1326#"
#     Output: "acz"
# 
#     1   -> a
#     3   -> c
#     26# -> z
# 
# Example 3
# 
#     Input: $str = "25#24#123"
#     Output: "yxabc"
# 
#     25# -> y
#     24# -> x
#     1   -> a
#     2   -> b
#     3   -> c
# 
# Example 4
# 
#     Input: $str = "20#5"
#     Output: "te"
# 
#     20# -> t
#     5   -> e
# 
# Example 5
# 
#     Input: $str = "1910#26#"
#     Output: "aijz"
# 
#     1   -> a
#     9   -> i
#     10# -> j
#     26# -> z
# 

package require Tcl 8.6
package require tcltest

set cases {
    { "10#11#12"  "jkab" "Example 1"}
    {    "1326#"   "acz" "Example 2"}
    {"25#24#123" "yxabc" "Example 3"}
    {     "20#5"    "te" "Example 4"}
    { "1910#26#"  "aijz" "Example 5"}
}

proc decrypt_string {str} {
    set result ""
    while {$str ne ""} {
        if {[regexp {^(\d{2})#} $str match num]} {
            append result [format %c [expr {$num + 96}]]
            set str [string range $str [expr {[string length $match]}] end]
        } elseif {[regexp {^(\d)} $str match num]} {
            append result [format %c [expr {$num + 96}]]
            set str [string range $str 1 end]
        }
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        decrypt_string [lindex $case 0]
    } [lindex $case 1]
}

exit 0

