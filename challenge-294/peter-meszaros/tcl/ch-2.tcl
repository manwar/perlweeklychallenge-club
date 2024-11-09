#!/usr/bin/env tclsh
#
# Task 2: Next Permutation
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# 
# Write a script to find out the next permutation of the given array.
# 
#     The next permutation of an array of integers is the next lexicographically
#     greater permutation of its integer.
# 
# Example 1
# 
#     Input: @ints = (1, 2, 3)
#     Output: (1, 3, 2)
# 
#     Permutations of (1, 2, 3) arranged lexicographically:
#     (1, 2, 3)
#     (1, 3, 2)
#     (2, 1, 3)
#     (2, 3, 1)
#     (3, 1, 2)
#     (3, 2, 1)
# 
# Example 2
# 
#     Input: @ints = (2, 1, 3)
#     Output: (2, 3, 1)
# 
# Example 3
# 
#     Input: @ints = (3, 1, 2)
#     Output: (3, 2, 1)
# 

package require tcltest
package require math::combinatorics 

set cases {
    {{1 2 3} {1 3 2} "Example 1"}
    {{2 1 3} {2 3 1} "Example 2"}
    {{3 1 2} {3 2 1} "Example 3"}
    {{2 3 1} {3 2 1} "Example 4"}
}


proc next_permutation {l} {
    set len [llength $l]
    set perm [::math::combinatorics::permutationObj create "perm" $len]
    $perm setElements $l
    set p [$perm nextElements]
    while {[llength $p] == $len} {
        for {set i 0} {$i < $len} {incr i} {
            if {[lindex $l $i] < [lindex $p $i]} {
                $perm destroy
                return $p
            } elseif {[lindex $l $i] > [lindex $p $i]} {
                break
            }
        }
        set p [$perm nextElements]
    }
    $perm destroy
    return
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       next_permutation [lindex $case 0]
    } [lindex $case 1]
}

exit 0
