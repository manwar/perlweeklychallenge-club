#!/usr/bin/env tclsh
#
# Task 2: Subset Equilibrium
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of numbers.  Write a script to find all proper subsets
# with more than one element where the sum of elements equals the sum of their
# indices.
# 
# Example 1
# 
#     Input: @nums = (2, 1, 4, 3)
#     Output: (2, 1), (1, 4), (4, 3), (2, 3)
# 
#     Subset 1: (2, 1)
#     Values: 2 + 1 = 3
#     Positions: 1 + 2 = 3
# 
#     Subset 2: (1, 4)
#     Values: 1 + 4 = 5
#     Positions: 2 + 3 = 5
# 
#     Subset 3: (4, 3)
#     Values: 4 + 3 = 7
#     Positions: 3 + 4 = 7
# 
#     Subset 4: (2, 3)
#     Values: 2 + 3 = 5
#     Positions: 1 + 4 = 5
# 
# Example 2
# 
#     Input: @nums = (3, 0, 3, 0)
#     Output: (3, 0), (3, 0, 3)
# 
#     Subset 1: (3, 0)
#     Values: 3 + 0 = 3
#     Positions: 1 + 2 = 3
# 
#     Subset 2: (3, 0, 3)
#     Values: 3 + 0 + 3 = 6
#     Positions: 1 + 2 + 3 = 6
# 
# Example 3
# 
#     Input: @nums = (5, 1, 1, 1)
#     Output: (5, 1, 1)
# 
#     Subset 1: (5, 1, 1)
#     Values: 5 + 1 + 1 = 7
#     Positions: 1 + 2 + 4 = 7
# 
# Example 4
# 
#     Input: @nums = (3, -1, 4, 2)
#     Output: (3, 2), (3, -1, 4)
# 
#     Subset 1: (3, 2)
#     Values: 3 + 2 = 5
#     Positions: 1 + 4 = 5
# 
#     Subset 2: (3, -1, 4)
#     Values: 3 + (-1) + 4 = 6
#     Positions: 1 + 2 + 3 = 6
# 
# Example 5
# 
#     Input: @nums = (10, 20, 30, 40)
#     Output: ()
# 

package require Tcl 8.6
package require tcltest
package require math::combinatorics 

set cases {
    {{2  1 4 3}    {{2 1} {2 3} {1 4} {4 3}} "Example 1"}
    {{3  0 3 0}    {{3 0} {3 0 3}}           "Example 2"}
    {{5  1 1 1}    {{5 1 1}}                 "Example 3"}
    {{3 -1 4 2}    {{3 2} {3 -1 4}}          "Example 4"}
    {{10 20 30 40} {}                        "Example 5"}
}

proc subset_equilibrium {nums} {

    set len [llength $nums]

    set ret {}
    for {set k 2} {$k < $len} {incr k} {
        set comb [::math::combinatorics::combinationObj create "comb" $len $k]
        set idxs {}
        for {set i 0} {$i < $len} {incr i} {
            lappend idxs $i
        }
        $comb setElements $idxs
        set c [$comb nextElements]
        while {[llength $c] == $k} {
            set sum1 [expr [join $c +] + [llength $c]]
            set sum2 0
            foreach idx $c {
                set sum2 [expr $sum2 + [lindex $nums $idx]]
            }
            if {$sum1 == $sum2} {
                set l {}    
                foreach idx $c {
                    lappend l [lindex $nums $idx]
                }
                lappend ret $l
            }
            set c [$comb nextElements]
        }
        $comb destroy
    }
    return $ret
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        subset_equilibrium [lindex $case 0]
    } [lindex $case 1]
}

exit 0

