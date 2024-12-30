#!/usr/bin/env tclsh
#
# Task 1: Ones and Zeroes
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of binary strings, @str, and two integers, $x and $y.
# 
# Write a script to return the size of the largest subset of @str such that there
# are at most $x 0's and $y 1's in the subset.
# 
# A set m is a subset of n if all elements of m are also elements of n.
# 
# Example 1
# 
#     Input: @str = ("10", "0001", "111001", "1", "0")
#            $x = 5
#            $y = 3
#     Output: 4
# 
#     The largest subset with at most five 0's and three 1's: ("10", "0001", "1",
#     "0")
# 
# Example 2
# 
#     Input: @str = ("10", "1", "0")
#            $x = 1
#            $y = 1
#     Output: 2
# 
#     The largest subset with at most one 0's and one 1's: ("1", "0")
# 

package require tcltest
package require math::combinatorics 

set cases {
    {{{"10" "0001" "111001" "1" "0"} 5 3} 4 "Example 1"}
    {{{"10"    "1"      "0"}         1 1} 2 "Example 2"}
}

proc ones_and_zeroes {p} {
    set l [lindex $p 0]
    set x [lindex $p 1]
    set y [lindex $p 2]

    set len [llength $l]
    set cnt 0

    for {set i 1} {$i <= $len} {incr i} {
        set comb [::math::combinatorics::combinationObj create "comb" $len $i]
        $comb setElements $l
        set p [$comb nextElements]
        while {[llength $p] == $i} {
            set str [join $p {}]
            set z [regsub -all {0} $str {} dummy]
            set o [regsub -all {1} $str {} dummy]
            if {$z <= $x && $o <= $y} {
                if {$i > $cnt} {
                    set cnt $i
                }
            }
            set p [$comb nextElements]
        }

        $comb destroy
    }
    return $cnt
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       ones_and_zeroes [lindex $case 0]
    } [lindex $case 1]
}

exit 0
