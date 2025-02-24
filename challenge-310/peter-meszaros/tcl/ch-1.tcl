#!/usr/bin/env tclsh
#
# Task 1: Arrays Intersection
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of array of integers.
# 
# Write a script to return the common elements in all the arrays.
# 
# Example 1
# 
#     Input: $list = ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )
#     Output: (1, 4)
# 
# Example 2
# 
#     Input: $list = ( [1, 0, 2, 3], [2, 4, 5] )
#     Output: (2)
# 
# Example 3
# 
#     Input: $list = ( [1, 2, 3], [4, 5], [6] )
#     Output: ()
# 

package require tcltest

set cases {
    {{{1 2 3 4} {4 5 6 1} {4 2 1 3}} {1 4} "Example 1"}
    {{{1 0 2 3} {2 4 5}}             {2}   "Example 2"}
    {{{1 2 3} {4 5} {6}}             {}    "Example 3"}
}

proc arrays_intersection {lists} {
    set numlists [llength $lists]
    set hash [dict create]
    foreach l $lists {
        foreach i [lsort -unique $l] {
            dict incr hash $i
        }
    }
    set hash_intersect [dict filter $hash value $numlists]
    return [lsort -integer [dict keys $hash_intersect]]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       arrays_intersection [lindex $case 0]
    } [lindex $case 1]
}

exit 0

