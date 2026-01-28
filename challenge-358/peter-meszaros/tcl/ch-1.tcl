#!/usr/bin/env tclsh
#
# Task 1: Max Str Value
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of alphanumeric string, @strings.  Write a script to
# find the max value of alphanumeric string in the given array. The numeric
# representation of the string, if it comprises of digits only otherwise length
# of the string.
# 
# Example 1
# 
#     Input: @strings = ("123", "45", "6")
#     Output: 123
# 
#     "123" -> 123
#     "45"  -> 45
#     "6"   -> 6
# 
# Example 2
# 
#     Input: @strings = ("abc", "de", "fghi")
#     Output: 4
# 
#     "abc"  -> 3
#     "de"   -> 2
#     "fghi" -> 4
# 
# Example 3
# 
#     Input: @strings = ("0012", "99", "a1b2c")
#     Output: 99
# 
#     "0012"  -> 12
#     "99"    -> 99
#     "a1b2c" -> 5
# 
# Example 4
# 
#     Input: @strings = ("x", "10", "xyz", "007")
#     Output: 10
# 
#     "x"   -> 1
#     "xyz" -> 3
#     "007" -> 7
#     "10"  -> 10
# 
# Example 5
# 
#     Input: @strings = ("hello123", "2026", "perl")
#     Output: 2026
# 
#     "hello123" -> 8
#     "perl"     -> 4
#     "2026"     -> 2026
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{"123" "45" "6"}            123 "Example 1"}
    {{"abc" "de" "fghi"}           4 "Example 2"}
    {{"0012" "99" "a1b2c"}        99 "Example 3"}
    {{"x" "10" "xyz" "007"}       10 "Example 4"}
    {{"hello123" "2026" "perl"} 2026 "Example 5"}
}

proc max_str_value {strs} {
    set max 0
    foreach str $strs {
        if {[string is integer -strict $str]} {
            set value [expr int($str)]
        } else {
            set value [string length $str]
        }
        if {$value > $max} {
            set max $value
        }
    }
    return $max
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        max_str_value [lindex $case 0]
    } [lindex $case 1]
}

exit 0

