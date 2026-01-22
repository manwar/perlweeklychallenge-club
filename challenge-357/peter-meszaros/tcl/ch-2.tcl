#!/usr/bin/env tclsh
#
# Task 2: Unique Fraction Generator
# 
# Submitted by: Yary
# 
# Given a positive integer N, generate all unique fractions you can create using
# integers from 1 to N and follow the rules below:
# 
#     - Use numbers 1 through N only (no zero)
#     - Create fractions like numerator/denominator
#     - List them in ascending order (from smallest to largest)
#     - If two fractions have the same value (like 1/2 and 2/4),
#       only show the one with the smallest numerator
# 
# Example 1
# 
#     Input: $int = 3
#     Output: 1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1
# 
# Example 2
# 
#     Input: $int = 4
#     Output: 1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1
# 
# Example 3
# 
#     Input: $int = 1
#     Output: 1/1
# 
# Example 4
# 
#     Input: $int = 6
#     Output: 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4,
#         4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1,
#         5/2, 3/1, 4/1, 5/1, 6/1
# 
# Example 5
# 
#     Input: $int = 5
#     Output: 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1,
#         5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1
# 

package require Tcl 8.6
package require tcltest

set cases {
    {3 {1/3 1/2 2/3 1/1 3/2 2/1 3/1} "Example 1"}
    {4 {1/4 1/3 1/2 2/3 3/4 1/1 4/3\
        3/2 2/1 3/1 4/1}             "Example 2"}
    {1 {1/1}                         "Example 3"}
    {6 {1/6 1/5 1/4 1/3 2/5 1/2 3/5\
        2/3 3/4 4/5 5/6 1/1 6/5 5/4\
        4/3 3/2 5/3 2/1 5/2 3/1 4/1\
        5/1 6/1}                     "Example 4"}
    {5 {1/5 1/4 1/3 2/5 1/2 3/5 2/3\
        3/4 4/5 1/1 5/4 4/3 3/2 5/3\
        2/1 5/2 3/1 4/1 5/1}         "Example 5"}
}

proc unique_fraction_generator {n} {
    array set seen {}
    array set fractions {}

    for {set denom 1} {$denom <= $n} {incr denom} {
        for {set num 1} {$num <= $n} {incr num} {
            set value [expr double($num) / $denom]
            if {![info exists seen($value)]} {
                set fractions($value) "$num/$denom"
                set seen($value) 1
            }
        }
    }

    set sorted_fractions [lsort -real [array names fractions]]
    set result {}
    foreach frac $sorted_fractions {
        lappend result [lindex [array get fractions $frac] 1]
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        unique_fraction_generator [lindex $case 0]
    } [lindex $case 1]
}

exit 0


