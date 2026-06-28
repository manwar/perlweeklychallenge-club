#!/usr/bin/env tclsh
#
# Task 2: Armstrong Number
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two integers, $base and $limit.  Write a script to find all
# Armstrong numbers in base $base that are less than $limit.
# 
# If raising each of the digits of a nonnegative integer to the power of the
# total number of digits, then taking the sum, equals the original number, it is
# an Armstrong number.
# 
# Example 1
# 
#     Input: $base = 10, $limit = 1000
#     Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407)
# 
# Example 2
# 
#     Input: $base = 7, $limit = 1000
#     Output: (0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250)
# 
# Example 3
# 
#     Input: $base = 16, $limit = 1000
#     Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645)
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{10  1000} {0 1 2 3 4 5 6 7 8 9 153 370 371 407}                       "Example 1"}
    {{ 7  1000} {0 1 2 3 4 5 6 10 25 32 45 133 134 152 250}                 "Example 2"}
    {{16  1000} {0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 342 371 520 584 645} "Example 3"}
}

proc armstrong_number {p} {
    set base  [lindex $p 0]
    set limit [lindex $p 1]

    set result {}
    for {set num 0} {$num < $limit} {incr num} {
        set n $num
        set digits {}
        set power 0
        while {$n > 0} {
            lappend digits [expr $n % $base]
            incr power
            set n [expr int($n / $base)]
        }

        set sum 0
        foreach d $digits {
            set sum [expr $sum + pow($d, $power)]
        }
        if {$sum == $num} {
            lappend result $num
        }
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        armstrong_number [lindex $case 0]
    } [lindex $case 1]
}

exit 0

