#!/usr/bin/env tclsh
#
# Task 1: Binary Prefix
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a binary array.
# 
# Write a script to return an array of booleans where the partial binary number
# up to that point is prime.
# 
# Example 1
# 
#     Input: @binary = (1, 0, 1)
#     Output: (false, true, true)
# 
#     Sub-arrays (base-10):
#     (1): 1 - not prime
#     (1, 0): 2 - prime
#     (1, 0, 1): 5 - prime
# 
# Example 2
# 
#     Input: @binary = (1, 1, 0)
#     Output: (false, true, false)
# 
#     Sub-arrays (base-10):
#     (1): 1 - not prime
#     (1, 1): 3 - prime
#     (1, 1, 0): 6 - not prime
# 
# Example 3
# 
#     Input: @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)
#     Output: (false, true, true, false, false, true, false, false, false, false,
#         false, false, false, false, false, false, false, false, false, true)
# 

package require tcltest

set cases {
    {{1 0 1} {0 1 1} "Example 1"}
    {{1 1 0} {0 1 0} "Example 2"}
    {{1 1 1 1 0 1 0 0 0 0 1 0 1 0 0 1 0 0 0 1} {0 1 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1} "Example 3"}
}

proc is_prime {n} {

    if {$n <= 1} {
        return 0
    }

    set v [expr int(sqrt($n))]

    for {set i 2} {$i <= $v} {incr i} {
        if {[expr $n % $i] == 0} {
            return 0
        }
    }

    return 1
}

proc binary_prefix {l} {
    set len [llength $l]
    set ret {}
    for {set i 0} {$i < $len} {incr i} {
        set n 0
        for {set j 0} {$j <= $i} {incr j} {
            set n [expr $n * 2 + [lindex $l $j]]
        }
        lset ret $i [is_prime $n]
    }
    return $ret
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       binary_prefix [lindex $case 0]
    } [lindex $case 1]
}

exit 0
