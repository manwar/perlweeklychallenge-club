#!/usr/bin/env tclsh
#
# Task 1: Reverse Base
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string representing a number, and an integer specifying the
# base of that representation. Write a function to convert this string to an
# integer. (For bases greater than 10, use characters A-Z, a-z, + and / in that
# order.)
# 
# Example 1
# 
#     Input: $num = "101010", $base = 2
#     Output: 42
# 
# Example 2
# 
#     Input: $num = "EEADEE", $base = 16
#     Output: 15642094
# 
# Example 3
# 
#     Input: $num = "755", $base = 8
#     Output: 493
# 
# Example 4
# 
#     Input: $num = "1BRJB", $base = 36
#     Output: 2228519
# 
# Example 5
# 
#     Input: $num = "7MyqL", $base = 64
#     Output: 123456789
# # 

package require Tcl 8.6
package require tcltest

set cases {
    {{"101010"  2}        42 "Example 1"}
    {{"EEADEE" 16}  15642094 "Example 2"}
    {{"755"     8}       493 "Example 3"}
    {{"1BRJB"  36}   2228519 "Example 4"}
    {{"7MyqL"  64} 123456789 "Example 5"}
}

proc reverse_base {p} {
    set num [lindex $p 0]
    set base [lindex $p 1]

    set result 0
    set len [string length $num]
    for {set i 0} {$i < $len} {incr i} {
        set digit [string index $num $i]
        if {[string is digit $digit]} {
            set value [expr [scan $digit %d]]
        } elseif {[string is upper $digit]} {
            set value [expr [scan $digit %c] - 55]
        } elseif {[string is lower $digit]} {
            set value [expr [scan $digit %c] - 61]
        } elseif {$digit eq "+"} {
            set value 62
        } elseif {$digit eq "/"} {
            set value 63
        } else {
            return -1
        }
        if {$value >= $base} {
            return -1
        }
        set result [expr {$result * $base + $value}]

    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        reverse_base [lindex $case 0]
    } [lindex $case 1]
}

exit 0

