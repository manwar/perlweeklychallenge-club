#!/usr/bin/env tclsh
#
# Task 1: Beautiful Arrangement
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a positive integer, $int.
# 
# Write a script to return the number of beautiful arrangements that you can
# construct.
# 
# A permutation of n integers, 1-indexed, is considered a beautiful arrangement
# if for every i (1 <= i <= n) either of the following is true:
# 
#     1) perm[i] is divisible by i
#     2) i is divisible by perm[i]
# 
# Example 1
# 
#     Input: $n = 2
#     Output: 2
# 
#     1st arrangement: [1, 2]
#         perm[1] is divisible by i = 1
#         perm[2] is divisible by i = 2
#     2nd arrangement: [2, 1]
#         perm[1] is divisible by i = 1
#         i=2 is divisible by perm[2] = 1
# 
# Example 2
# 
#     Input: $n = 1
#     Output: 1
# 
# Example 3
# 
#     Input: $n = 10
#     Output: 700
# 

package require tcltest
package require math::combinatorics 

set cases {
    { 2   2 "Example 1"}
    { 1   1 "Example 2"}
    {10 700 "Example 3"}
}


proc beautiful_arrangement {n} {

    set data {}
    for {set i 1} {$i <= $n} {incr i} {
        lappend data $i
    }

    set perm [::math::combinatorics::permutationObj create "perm" $n]
    $perm setElements $data

    set cnt 0
    set p [$perm nextElements]
    while {[llength $p] == $n} {
        set good 1
        foreach i $p {
            set v [lindex $p [expr $i - 1]]
            if {[expr $i % $v] && [expr $v % $i]} {
                set good 0
                break
            }
        }
        if {$good} {
            incr cnt
        }
        set p [$perm nextElements]
    }

    $perm destroy
    return $cnt
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       beautiful_arrangement [lindex $case 0]
    } [lindex $case 1]
}

exit 0

