#!/usr/bin/env tclsh
#
# Task 2: Nested Array
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints of length n containing permutation of
# the numbers in the range [0, n - 1].
# 
# Write a script to build a set, set[i] = ints[i], ints[ints[i]],
# ints[ints[ints[i]]], ..., subjected to the following rules:
# 
#     1. The first element in set[i] starts with the selection of elements
#         ints[i].
#     2. The next element in set[i] should be ints[ints[i]], and then
#         ints[ints[ints[i]]], and so on.
#     3. We stop adding right before a duplicate element occurs in set[i].
# 
# Return the longest length of a set set[i].
# 
# Example 1
# 
#     Input: @ints = (5, 4, 0, 3, 1, 6, 2)
#     Output: 4
# 
#     ints[0] = 5
#     ints[1] = 4
#     ints[2] = 0
#     ints[3] = 3
#     ints[4] = 1
#     ints[5] = 6
#     ints[6] = 2
# 
#     One of the longest sets set[k]:
#     set[0] = {ints[0], ints[5], ints[6], ints[2]} = {5, 6, 2, 0}
# 
# Example 2
# 
#     Input: @ints = (0, 1, 2)
#     Output: 1
# 

package require tcltest

set cases {
    {{5 4 0 3 1 6 2} 4 "Example 1"}
    {{0 1 2}         1 "Example 2"}
}

proc nested_array {l} {
    set res 0
    set len [llength $l]

    for {set i 0} {$i < $len} {incr i} {
        set cnt 1
        set ll $l
        set n [lindex $ll $i]
        lset ll $i -1
        while {[lindex $ll $n] != -1} {
           incr cnt
           set t $n
           set n [lindex $ll $n]
           lset ll $t -1
        }
        if {$cnt > $res} {
            set res $cnt
        }
    }
    return $res
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        nested_array [lindex $case 0]
    } [lindex $case 1]
}

exit 0

