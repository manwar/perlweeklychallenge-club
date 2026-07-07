#!/usr/bin/env tclsh
#
# Task 1: Same Row Column
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a n x n matrix containing integers from 1 to n.  Write a script
# to find if every row and every column contains all the integers from 1 to n.
# 
# Example 1
# 
#     Input: @matrix = ([1, 2, 3, 4],
#                       [2, 3, 4, 1],
#                       [3, 4, 1, 2],
#                       [4, 1, 2, 3],)
#     Output: true
# 
# Example 2
# 
#     Input: @matrix = ([1])
#     Output: true
# 
# Example 3
# 
#     Input: @matrix = ([1, 2, 5],
#                       [5, 1, 2],
#                       [2, 5, 1],)
#     Output: false
# 
#     Elements are out of range 1..3.
# 
# Example 4
# 
#     Input: @matrix = ([1, 2, 3],
#                       [1, 2, 3],
#                       [1, 2, 3],)
#     Output: false
# 
# Example 5
# 
#     Input: @matrix = ([1, 2, 3],
#                       [3, 1, 2],
#                       [3, 2, 1],)
#     Output: false
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{{1 2 3 4}
      {2 3 4 1}
      {3 4 1 2}
      {4 1 2 3}} true "Example 1"}
    {{{1}}       true "Example 2"}
    {{{1 2 5}
      {5 1 2}
      {2 5 1}}        false "Example 3"}
    {{{1 2 3}
      {1 2 3}
      {1 2 3}}  false "Example 4"}
    {{{1 2 3}
      {3 1 2}
      {3 2 1}}  false "Example 5"}
}

proc same_row_column {matrix} {
    set n [llength $matrix]

    for {set i 0} {$i < $n} {incr i} {
        array set col {}
        array set row {}
        for {set j 0} {$j < $n} {incr j} {
            set colval [lindex [lindex $matrix $i] $j]
            set rowval [lindex [lindex $matrix $j] $i]
            if {$rowval < 1 || $rowval > $n || $colval < 1 || $colval > $n} {
                return false
            }
            lappend col($colval) 1
            lappend row($rowval) 1
        }
        if {[llength [array names col]] != $n || [llength [array names row]] != $n} {
            return false
        }
    }
    return true
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        same_row_column [lindex $case 0]
    } [lindex $case 1]
}

exit 0

