#!/usr/bin/env tclsh
#
# Task 2: Total XOR
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers.
# 
# Write a script to return the sum of total XOR for every subset of given
# array.
# 
# Example 1
# 
#     Input: @ints = (1, 3)
#     Output: 6
# 
#     Subset [1],    total XOR = 1
#     Subset [3],    total XOR = 3
#     Subset [1, 3], total XOR => 1 XOR 3 => 2
# 
#     Sum of total XOR => 1 + 3 + 2 => 6
# 
# Example 2
# 
#     Input: @ints = (5, 1, 6)
#     Output: 28
# 
#     Subset [5],       total XOR = 5
#     Subset [1],       total XOR = 1
#     Subset [6],       total XOR = 6
#     Subset [5, 1],    total XOR => 5 XOR 1 => 4
#     Subset [5, 6],    total XOR => 5 XOR 6 => 3
#     Subset [1, 6],    total XOR => 1 XOR 6 => 7
#     Subset [5, 1, 6], total XOR => 5 XOR 1 XOR 6 => 2
# 
#     Sum of total XOR => 5 + 1 + 6 + 4 + 3 + 7 + 2 => 28
# 
# Example 3
# 
#     Input: @ints = (3, 4, 5, 6, 7, 8)
#     Output: 480
# 

package require tcltest
package require math::combinatorics 

set cases {
    {{1 3}           6 "Example 1"}
    {{5 1 6}        28 "Example 2"}
    {{3 4 5 6 7 8} 480 "Example 3"}
}

proc total_xor {ints} {

    set len [llength $ints]
    set result 0
    for {set i 1} {$i <= $len} {incr i} {
        set comb [::math::combinatorics::combinationObj create "comb" $len $i]
        $comb setElements $ints
        set c [$comb nextElements]
        while {[llength $c] == $i} {
            set sum 0
            foreach elem $c {
                set sum [expr $sum ^ $elem]
            }
            set result [expr $result + $sum]
            set c [$comb nextElements]
        }
        $comb destroy
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        total_xor [lindex $case 0]
    } [lindex $case 1]
}

exit 0

