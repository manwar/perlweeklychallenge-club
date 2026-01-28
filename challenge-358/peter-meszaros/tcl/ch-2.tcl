#!/usr/bin/env tclsh
#
# Task 2: Encrypted String
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string $str and an integer $int.  Write a script to encrypt the
# string using the algorithm - for each character $char in $str, replace $char
# with the $int th character after $char in the alphabet, wrapping if needed and
# return the encrypted string.
# 
# Example 1
# 
#     Input: $str = "abc", $int = 1
#     Output: "bcd"
# 
# Example 2
# 
#     Input: $str = "xyz", $int = 2
#     Output: "zab"
# 
# Example 3
# 
#     Input: $str = "abc", $int = 27
#     Output: "bcd"
# 
# Example 4
# 
#     Input: $str = "hello", $int = 5
#     Output: "mjqqt"
# 
# Example 5
# 
#     Input: $str = "perl", $int = 26
#     Output: "perl"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{"abc"   1}   "bcd" "Example 1"}
    {{"xyz"   2}   "zab" "Example 2"}
    {{"abc"  27}   "bcd" "Example 3"}
    {{"hello" 5} "mjqqt" "Example 4"}
    {{"perl" 26}  "perl" "Example 5"}
}

proc encrypted_string {params} {
    set str [lindex $params 0]
    set int [lindex $params 1]

    set result ""
    foreach char [split $str ""] {
        set base [scan "a" %c]
        set offset [expr ([scan $char %c] - $base + $int) % 26]
        append result [format %c [expr $base + $offset]]
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        encrypted_string [lindex $case 0]
    } [lindex $case 1]
}

exit 0

