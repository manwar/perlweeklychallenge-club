#!/usr/bin/env tclsh
#
# Task 1: Reverse String
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string.  Write a script to reverse the given string without
# using standard reverse function.
# 
# Example 1
# 
#     Input: $str = ""
#     Output: ""
# 
# Example 2
# 
#     Input: $str = "reverse the given string"
#     Output: "gnirts nevig eht esrever"
# 
# Example 3
# 
#     Input: $str = "Perl is Awesome"
#     Output: "emosewA si lreP"
# 
# Example 4
# 
#     Input: $str = "v1.0.0-Beta!"
#     Output: "!ateB-0.0.1v"
# 
# Example 5
# 
#     Input: $str = "racecar"
#     Output: "racecar"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {""                         ""                         "Example 1"}
    {"reverse the given string" "gnirts nevig eht esrever" "Example 2"}
    {"Perl is Awesome"          "emosewA si lreP"          "Example 3"}
    {"v1.0.0-Beta!"             "!ateB-0.0.1v"             "Example 4"}
    {"racecar"                  "racecar"                  "Example 5"}
}

proc reverse_string {str} {
    set reversed ""
    for {set i [expr [string length $str] - 1]} {$i >= 0} {incr i -1} {
        append reversed [string index $str $i]
    }
    return $reversed
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        reverse_string [lindex $case 0]
    } [lindex $case 1]
}

exit 0

