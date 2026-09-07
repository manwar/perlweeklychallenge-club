#!/usr/bin/env tclsh
#
# Task 2: Rational Numbers
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two strings representing non-negative rational numbers.  Write a
# script to return true if the two given rational numbers are same otherwise
# false.
# 
# Example 1
# 
#     Input: $rat1 = "0.(12)"
#            $rat2 = "0.(121)"
#     Output: false
# 
#     Expansion of "0.(12)"  = 0.12 12 12 12
#     Expansion of "0.(121)" = 0.121 121 121
# 
# Example 2
# 
#     Input: $rat1 = "0.1(23)"
#            $rat2 = "0.12(32)"
#     Output: false
# 
# Example 3
# 
#     Input: $rat1 = "0.1(234)"
#            $rat2 = "0.12(342)"
#     Output: true
# 
#     Expansion of "0.1(234)"  = 0.1 234 234 234
#     Expansion of "0.12(342)" = 0.12 342 342 342
# 
# Example 4
# 
#     Input: $rat1 = "12.99(99)"
#            $rat2 = "13."
#     Output: true
# 
# Example 5
# 
#     Input: $rat1 = "0.(123)"
#            $rat2 = "0.1(231)"
#     Output: true
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{"0.(12)"    "0.(121)"  } false "Example 1"}
    {{"0.1(23)"   "0.12(32)" } true  "Example 2"}
    {{"0.1(234)"  "0.12(342)"} true  "Example 3"}
    {{"12.99(99)" "13."      } true  "Example 4"}
    {{"0.(123)"   "0.1(231)" } true  "Example 5"}
}

proc to_fraction {s} {
    set parts [split $s "."]
    set whole [lindex $parts 0]
    set decimal [lindex $parts 1]

    if {[string match *(* $decimal]} {
        regexp {^([^()]*)\((\d+)\)$} $decimal -> non_repeat repeat
    } else {
        set non_repeat $decimal
        set repeat ""
    }

    set n [string length $non_repeat]
    set r [string length $repeat]

    if {$non_repeat == ""} {
        set non_repeat 0
    } else {
        set non_repeat [expr int($non_repeat)]
    }

    if {$r == 0} {
        set den [expr 10**$n]
        set num [expr $whole * $den + $non_repeat]
        return [list $num $den]
    }

    set pow_n [expr 10**$n]
    set pow_r [expr 10**$r]
    set cycle [expr $pow_r - 1]
    set den [expr $pow_n * $cycle]
    set num [expr $whole * $den + $non_repeat * $cycle + int($repeat)]

    return [list $num $den]
}

proc rational_numbers {p} {
    set rat1 [lindex $p 0]
    set rat2 [lindex $p 1]

    set frac1 [to_fraction $rat1]
    set frac2 [to_fraction $rat2]

    set num1 [lindex $frac1 0]
    set den1 [lindex $frac1 1]
    set num2 [lindex $frac2 0]
    set den2 [lindex $frac2 1]

    return [expr $num1 * $den2 == $num2 * $den1 ? true : false]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        rational_numbers [lindex $case 0]
    } [lindex $case 1]
}

exit 0

