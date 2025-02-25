#!/usr/bin/env tclsh
#
# Task 1: String Compression
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string of alphabetic characters, $chars.
# 
# Write a script to compress the string with run-length encoding, as shown in the
# examples.
# 
# A compressed unit can be either a single character or a count followed by a
# character.
# 
# BONUS: Write a decompression function.
# 
# Example 1
# 
#     Input: $chars = "abbc"
#     Output: "a2bc"
# 
# Example 2
# 
#     Input: $chars = "aaabccc"
#     Output: "3ab3c"
# 
# Example 3
# 
#     Input: $chars = "abcc"
#     Output: "ab2c"
# 

package require tcltest

set cases {
    {"abbc"    "a2bc"  "Example 1"}
    {"aaabccc" "3ab3c" "Example 2"}
    {"abcc"    "ab2c"  "Example 3"}
}

proc string_compression {str} {

    set out ""

    set l [regexp -inline -all -expanded -- {([a-z])\1*} $str]
    for {set i 0} {$i < [llength $l]} {incr i 2} {
        set s [lindex $l $i]
        set len [string length $s]
        set c [string index $s 0]
        if {$len > 1} {
            append out $len $c
        } else {
            append out $c
        }
    }
    return $out
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       string_compression [lindex $case 0]
    } [lindex $case 1]
}

exit 0
