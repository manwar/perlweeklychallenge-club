#!/usr/bin/env tclsh
#
# Task 1: Strong Password
#
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str.
# 
# Write a program to return the minimum number of steps required to make the
# given string very strong password. If it is already strong then return 0.
# 
# Criteria:
# 
# - It must have at least 6 characters.
# - It must contains at least one lowercase letter, at least one upper case
#   letter and at least one digit.
# - It shouldn't contain 3 repeating characters in a row.
# 
# Following can be considered as one step:
# 
# - Insert one character
# - Delete one character
# - Replace one character with another
# 
# Example 1
# 
# Input: $str = "a"
# Output: 5
# 
# Example 2
# 
# Input: $str = "aB2"
# Output: 3
# 
# Example 3
# 
# Input: $str = "PaaSW0rd"
# Output: 0
# 
# Example 4
# 
# Input: $str = "Paaasw0rd"
# Output: 1
# 
# Example 5
# 
# Input: $str = "aaaaa"
# Output: 2
# 

package require tcltest

set cases {
    {a         5 "Example 1"}
    {aB2       3 "Example 2"}
    {PaaSW0rd  0 "Example 3"}
    {Paaasw0rd 1 "Example 4"}
    {aaaaa     2 "Example 5"}
}

proc strong_password {p} {
    set cnt 0

    if {![regexp {[a-z]} $p]} {
        if {[regsub {(.)\1{2}} $p {\1\1x} x] == 1} {
            set p $x
        } else {
            append p "x"
        }
        incr cnt
    }
    if {![regexp {[A-Z]} $p]} {
        if {[regsub {(.)\1{2}} $p {\1\1X} x] == 1} {
            set p $x
        } else {
            append p "X"
        }
        incr cnt
    }
    if {![regexp {[0-9]} $p]} {
        if {[regsub {(.)\1{2}} $p {\1\10} x] == 1} {
            set p $x
        } else {
            append p "0"
        }
        incr cnt
    }

    while {[regexp {(.)\1{2}} $p _ c]} {
        if {$c == "x"} {
            set c "y"
        }
        if {[regsub {(.)\1{2}} $p {\1\1$c} x] == 1} {
            set p $x
            incr cnt
        }
    }

    set l [string length $p]
    if {$l < 6} {
        if {[string index $p end] == "x"} {
            set c "y"
        } else {
            set c "x"
        }
        set n [expr 6 - $l]
        append p string repeat $c $n]
        incr cnt $n
    }

    return $cnt
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
      strong_password [lindex $case 0]
    } [lindex $case 1]
}

exit 0

