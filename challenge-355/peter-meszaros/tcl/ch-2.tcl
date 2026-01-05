#!/usr/bin/env tclsh
#
# Task 2: Mountain Array
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# Write a script to return true if the given array is a valid mountain array.
# An array is mountain if and only if:
# 
#     1) arr.length >= 3
#     and
#     2) There exists some i with 0 < i < arr.length - 1 such that:
#     arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
#     arr[i] > arr[i + 1] > ... > arr[arr.length - 1]
# 
# Example 1
# 
#     Input: @ints = (1, 2, 3, 4, 5)
#     Output: false
# 
# Example 2
# 
#     Input: @ints = (0, 2, 4, 6, 4, 2, 0)
#     Output: true
# 
# Example 3
# 
#     Input: @ints = (5, 4, 3, 2, 1)
#     Output: false
# 
# Example 4
# 
#     Input: @ints = (1, 3, 5, 5, 4, 2)
#     Output: false
# 
# Example 5
# 
#     Input: @ints = (1, 3, 2)
#     Output: true
# 

package require Tcl 8.6
package require tcltest

set cases {
    {    {1 2 3 4 5} false "Example 1"}
    {{0 2 4 6 4 2 0} true  "Example 2"}
    {    {5 4 3 2 1} false "Example 3"}
    {  {1 3 5 5 4 2} false "Example 4"}
    {        {1 3 2} true  "Example 5"}
}

proc mountain_array {ints} {
    if {[llength $ints] < 3} {
        return false
    }

    set mountain false
    set up_down "up"
    for {set i 1} {$i < [expr [llength $ints] - 1]} {incr i} {
        if {$up_down eq "up"} {
            if {[lindex $ints $i] > [lindex $ints [expr $i - 1]] && \
                [lindex $ints $i] > [lindex $ints [expr $i + 1]]} {
                set up_down "down"
                set mountain true
            } elseif {[lindex $ints $i] <= [lindex $ints [expr $i - 1]] || \
                      [lindex $ints $i] >= [lindex $ints [expr $i + 1]]} {
                set mountain false
                break
            }
        } else {
            if {[lindex $ints $i] >= [lindex $ints [expr $i - 1]] || \
                [lindex $ints $i] <= [lindex $ints [expr $i + 1]]} {
                set mountain false
                break
            }
        }
    }
    return $mountain
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        mountain_array [lindex $case 0]
    } [lindex $case 1]
}

exit 0

