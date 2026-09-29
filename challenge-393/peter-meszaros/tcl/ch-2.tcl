#!/usr/bin/env tclsh
#
# Task 2: Prime Step
# 
# Submitted by: Ulrich Rieke
# 
# You are given a string with English alphabetic characters only.  What is the
# absolute difference of the sum of the ASCII values of the characters in the
# string to the nearest prime number?
# 
# Example 1
# 
#     Input: $str = "hello"
#     Output: 9
# 
#     The ordinal values of "hello" are [104,101,108,108,111], summing up to 532.
#     The nearest prime number to 532 is 523, resulting in an absolute difference of 9.
# 
# Example 2
# 
#     Input: $str = "football"
#     Output: 2
# 
#     Starting with the values [102,111,111,116,98,97,108,108] and the sum 841.
#     We find 839 as the nearest prime number, so the difference is 2.
# 
# Example 3
# 
#     Input: $str = "a"
#     Output: 0
# 
# Example 4
# 
#     Input: $str = "challenge"
#     Output: 2
# 
#     The ordinal values of "challenge" are [99, 104, 97, 108, 108, 101, 110, 103, 101], which sum up to 931.
#     The nearest prime number to 931 is 929, so the difference is 2.
# 
# Example 5
# 
#     Input: $str = "perl"
#     Output: 2
# 
#     The ordinal values of "perl" are [112, 101, 114, 108], summing up to 435.
#     Nearest prime is 433, so the difference is 2.
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"hello"     9 "Example 1"}
    {"football"  2 "Example 2"}
    {"a"         0 "Example 3"}
    {"challenge" 2 "Example 4"}
    {"perl"      2 "Example 5"}
}

proc is_prime {n} {
    if {$n < 2} {
        return 0
    }
    if {$n == 2} {
        return 1
    }
    if {$n % 2 == 0} {
        return 0
    }

    set limit [expr int(sqrt($n))]
    for {set i 3} {$i <= $limit} {incr i 2} {
        if {$n % $i == 0} {
            return 0
        }
    }
    return 1
}

proc prime_step {str} {
    set sum 0
    foreach char [split $str ""] {
        set sum [expr $sum + [scan $char %c]]
    }

    set i 0
    while {1} {
        set lower [expr $sum - $i]
        set upper [expr $sum + $i]

        if {[is_prime $lower]} {
            return [expr abs($sum - $lower)]
        }
        if {[is_prime $upper]} {
            return [expr abs($sum - $upper)]
        }
        incr i
    }
    return -1
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        prime_step [lindex $case 0]
    } [lindex $case 1]
}

exit 0

