#!/usr/bin/env tclsh
#
# Task 2: Group Digit Sum
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str, made up of digits, and an integer, $int, which is
# less than the length of the given string.
# 
# Write a script to divide the given string into consecutive groups of size $int
# (plus one for leftovers if any). Then sum the digits of each group, and
# concatenate all group sums to create a new string. If the length of the new
# string is less than or equal to the given integer then return the new string,
# otherwise continue the process.
# 
# Example 1
# 
#     Input: $str = "111122333", $int = 3
#     Output: "359"
# 
#     Step 1: "111", "122", "333" => "359"
# 
# Example 2
# 
#     Input: $str = "1222312", $int = 2
#     Output: "76"
# 
#     Step 1: "12", "22", "31", "2" => "3442"
#     Step 2: "34", "42" => "76"
# 
# Example 3
# 
#     Input: $str = "100012121001", $int = 4
#     Output: "162"
# 
#     Step 1: "1000", "1212", "1001" => "162"
# 

package require tcltest

set cases {
    {{"111122333"    3} 359 "Example 1"}
    {{"1222312"      2}  76 "Example 2"}
    {{"100012121001" 4} 162 "Example 3"}
}

proc ladd l {
    if {![llength $l]} {return 0}
    return [expr [join $l +]]
}

proc group_digit_sum {p} {
    set str [lindex $p 0]
    set int [lindex $p 1]

    set new_str {}
    while {[string length $str] > $int} {
        set new_str {}
        for {set i 0} {$i < [string length $str]} {incr i $int} {
            set s [string range $str $i [expr $i + $int - 1]]
            append new_str [ladd [split $s {}]]
        }
        set str $new_str
    }
    return $new_str
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       group_digit_sum [lindex $case 0]
    } [lindex $case 1]
}

exit 0
