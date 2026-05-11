#!/usr/bin/env tclsh
#
# Task 2: List Division
# 
# Submitted by: Mark Anderson
# 
# You are given a list and a non-negative integer.  Write a script to divide the
# given list into given non-negative integer equal parts. Return -1 if the
# integer is more than the size of the list.
# 
# Example 1
# 
#     Input: @list = (1,2,3,4,5), $n = 2
#     Output: ((1,2,3), (4,5))
# 
#     5 / 2 = 2 remainder 1.
#     The extra element goes into the first chunk.
# 
# Example 2
# 
#     Input: @list = (1,2,3,4,5,6), $n = 3
#     Output: ((1,2), (3,4), (5,6))
# 
#     6 / 3 = 2 remainder 0.
# 
# Example 3
# 
#     Input: @list = (1,2,3), $n = 2
#     Output: ((1,2), (3))
# 
# Example 4
# 
#     Input: @list = (1,2,3,4,5,6,7,8,9,10), $n = 5
#     Output: ((1,2), (3,4), (5,6), (7,8), (9,10))
# 
# Example 5
# 
#     Input: @list = (1,2,3), $n = 4
#     Output: -1
# 
# Example 6
# 
#     Input: @list = (72,57,89,55,36,84,10,95,99,35), $n = 7;
#     Output: ((72,57), (89,55), (36,84), (10), (95), (99), (35))
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{{1 2 3 4 5}                     2}  {{1 2 3} {4 5}}                       "Example 1"} 
    {{{1 2 3 4 5 6}                   3}  {{1 2} {3 4} {5 6}}                   "Example 2"} 
    {{{1 2 3}                         2}  {{1 2} 3}                             "Example 3"} 
    {{{1 2 3 4 5 6 7 8 9 10}          5}  {{1 2} {3 4} {5 6} {7 8} {9 10}}      "Example 4"} 
    {{{1 2 3}                         4}  -1                                    "Example 5"} 
    {{{72 57 89 55 36 84 10 95 99 35} 7}  {{72 57} {89 55} {36 84} 10 95 99 35} "Example 6"} 
}

proc list_division {p} {
    set l [lindex $p 0]
    set n [lindex $p 1]

    if {$n > [llength $l]} {
        return -1
    }

    set size [expr {[llength $l] / $n}]
    set rem  [expr {[llength $l] % $n}]

    set result {};
    for {set i 0} {$i < $n} {incr i} {
        set chunk_size [expr $size + ($rem > 0 ? 1 : 0)]
        lappend result [lrange $l 0 [expr $chunk_size - 1]]
        set l [lrange $l $chunk_size end]
        incr rem -1
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        list_division [lindex $case 0]
    } [lindex $case 1]
}

exit 0

