#!/usr/bin/env tclsh
#
# Task 2: Hamming Distance
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# 
# Write a script to return the sum of Hamming distances between all the pairs of
# the integers in the given array of integers.
# 
# The Hamming distance between two integers is the number of places in which
# their binary representations differ.
# 
# Example 1
# 
#     Input: @ints = (4, 14, 2)
#     Output: 6
# 
#     Binary representation:
#     4  => 0100
#     14 => 1110
#     2  => 0010
# 
#     HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2
#     + 2 + 2 = 6.
# 
# Example 2
# 
#     Input: @ints = (4, 14, 4)
#     Output: 4
# 

package require tcltest
package require math::combinatorics 

set cases {
    {{4 14 2} 6 "Example 1"}
    {{4 14 4} 4 "Example 2"}
}

proc calculate_hamming_distance {n1 n2} {
    set x [expr {$n1 ^ $n2}]
    set dist 0

    while {$x > 0} {
        set dist [expr $dist + ($x & 1)]
        set x [expr $x >> 1]
    }

    return $dist
}

proc hamming_distance {ints} {
    set len [llength $ints]
    set comb [::math::combinatorics::combinationObj create "comb" $len 2]
    $comb setElements $ints

    set sum 0
    set p [$comb nextElements]
    while {[llength $p] == 2} {
        set sum [expr {$sum + [calculate_hamming_distance {*}$p]}]
        set p [$comb nextElements]
    }

    $comb destroy
    return $sum
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       hamming_distance [lindex $case 0]
    } [lindex $case 1]
}

exit 0

