#!/usr/bin/env tclsh
#
# Task 1: Equal Strings
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given three strings.
# 
# You are allowed to remove the rightmost character of a string to make all
# equals.
# 
# Write a script to return the number of operations to make it equal otherwise
# -1.
# 
# Example 1
# 
#     Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
#     Output: 2
# 
#     Operation 1: Delete "c" from the string "abc"
#     Operation 2: Delete "b" from the string "abb"
# 
# Example 2
# 
#     Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
#     Output: -1
# 
# Example 3
# 
#     Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
#     Output: 3
# 

package require tcltest

set cases {
    {{"abc" "abb" "ab"}   2 "Example 1"}
    {{"ayz" "cyz" "xyz"} -1 "Example 2"}
    {{"yza" "yzb" "yzc"}  3 "Example 3"}
}

proc equal_strings {strings} {

    set lengths [lmap s $strings {string length $s}]
    set max [tcl::mathfunc::max {*}$lengths]
    set ops 0
    for {set i 0} {$i < [llength $strings]} {incr i} {
        if {[lindex $lengths $i] == $max} {
            incr ops
        } elseif {[lindex $lengths $i] < [expr $max - 1]} {
            set ops -1
            break
        }
    }
    set max_2 [expr $max - 2]
    if {$ops != -1 && 
        !([string range [lindex $strings 0] 0 $max_2] == [string range [lindex $strings 1] 0 $max_2] &&
          [string range [lindex $strings 0] 0 $max_2] == [string range [lindex $strings 2] 0 $max_2])} {
        set ops -1
    }
    return $ops
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        equal_strings [lindex $case 0]
    } [lindex $case 1]
}

exit 0

