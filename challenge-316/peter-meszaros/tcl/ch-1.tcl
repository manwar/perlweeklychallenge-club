#!/usr/bin/env tclsh
#
# Task 1: Circular
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of words.
# 
# Write a script to find out whether the last character of each word is the first
# character of the following word.
# 
# Example 1
# 
#     Input: @list = ("perl", "loves", "scala")
#     Output: true
# 
# Example 2
# 
#     Input: @list = ("love", "the", "programming")
#     Output: false
# 
# Example 3
# 
#     Input: @list = ("java", "awk", "kotlin", "node.js")
#     Output: true
# 

package require tcltest

set cases {
    {{"perl" "loves" "scala"}          1 "Example 1"}
    {{"love" "the" "programming"}      0 "Example 2"}
    {{"java" "awk" "kotlin" "node.js"} 1 "Example 3"}
}

proc circular {l} {
    set n [expr [llength $l] - 1]
    for {set i 0} {$i < $n} {incr i} {
        set a [lindex $l $i]
        set b [lindex $l [expr $i + 1]]
        if {[string index $a end] ne [string index $b 0]} {
            return 0
        }
    }
    return 1
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       circular [lindex $case 0]
    } [lindex $case 1]
}

exit 0

