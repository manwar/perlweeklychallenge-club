#!/usr/bin/env tclsh
#
# Task 2: Reverse Equals
# 
# Submitted by: Roger Bell_West
# 
# You are given two arrays of integers, each containing the same elements as the
# other.
# 
# Write a script to return true if one array can be made to equal the other by
# reversing exactly one contiguous subarray.
# 
# Example 1
# 
#     Input: @source = (3, 2, 1, 4)
#            @target = (1, 2, 3, 4)
#     Output: true
# 
#     Reverse elements: 0-2
# 
# Example 2
# 
#     Input: @source = (1, 3, 4)
#            @target = (4, 1, 3)
#     Output: false
# 
# Example 3
# 
#     Input: @source = (2)
#            @target = (2)
#     Output: true
# 

package require tcltest

set cases {
    {{{3 2 1 4} {1 2 3 4}} 1 "Example 1"}
    {{{1 3 4}   {4 1 3}}   0 "Example 2"}
    {{{2}       {2}}       1 "Example 3"}
}

proc reverse_equals {p} {
    set source [lindex $p 0]
    set target [lindex $p 1]

    set len [llength $source]

    set start 0
    set end   [expr $len - 1]

    for {set i 0} {$i < $len} {incr i} {
        if {[lindex $source $i] != [lindex $target $i]} {
            set start $i
            break
        }
    }

    for {set i [expr {$len - 1}]} {$i >= 0} {incr i -1} {
        if {[lindex $source $i] != [lindex $target $i]} {
            set end $i
            break
        }
    }

    set source [lreplace $source $start $end {*}[lreverse [lrange $source $start $end]]]

    for {set i 0} {$i < $len} {incr i} {
        if {[lindex $source $i] != [lindex $target $i]} {
            return 0
        }
    }

    return 1
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       reverse_equals [lindex $case 0]
    } [lindex $case 1]
}

exit 0

