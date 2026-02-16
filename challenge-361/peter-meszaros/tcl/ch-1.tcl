#!/usr/bin/env tclsh
#
# Task 1: Zeckendorf Representation
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a positive integer (<= 100).  Write a script to return Zeckendorf
# Representation of the given integer.  Every positive integer can be uniquely
# represented as sum of non-consecutive Fibonacci numbers.
# 
# Example 1
# 
#     Input: $int = 4
#     Output: 3,1
# 
#     4 => 3 + 1 (non-consecutive fibonacci numbers)
# 
# Example 2
# 
#     Input: $int = 12
#     Output: 8,3,1
# 
#     12 => 8 + 3 + 1
# 
# Example 3
# 
#     Input: $int = 20
#     Output: 13,5,2
# 
#     20 => 13 + 5 + 2
# 
# Example 4
# 
#     Input: $int = 96
#     Output: 89,5,2
# 
#     96 => 89 + 5 + 2
# 
# Example 5
# 
#     Input: $int = 100
#     Output: 89,8,3
# 
#     100 => 89 + 8 + 3
# 

package require Tcl 8.6
package require tcltest

set cases {
    {  4    {3 1} "Example 1"}
    { 12  {8 3 1} "Example 2"}
    { 20 {13 5 2} "Example 3"}
    { 96 {89 5 2} "Example 4"}
    {100 {89 8 3} "Example 5"}
}

proc zeckendorf_representation {n} {
    set fib {1 2}
    while {[lindex $fib end] < $n} {
        lappend fib [expr [lindex $fib end] + [lindex $fib end-1]]
    }
    if {[lindex $fib end] > $n} {
        set fib [lrange $fib 0 end-1]
    }

    set result {}
    foreach f [lreverse $fib] {
        if {$f <= $n} {
            lappend result $f
            set n [expr $n - $f]
        }
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        zeckendorf_representation [lindex $case 0]
    } [lindex $case 1]
}

exit 0

