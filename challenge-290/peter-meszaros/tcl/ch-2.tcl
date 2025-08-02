#!/usr/bin/env tclsh
#
# Task 2: Luhn's Algorithm
# 
# Submitted by: Andrezgz
# 
# You are given a string $str containing digits (and possibly other characters
# which can be ignored). The last digit is the payload; consider it separately.
# Counting from the right, double the value of the first, third, etc. of the
# remaining digits.
# 
# For each value now greater than 9, sum its digits.
# 
# The correct check digit is that which, added to the sum of all values, would
# bring the total mod 10 to zero.
# 
# Return true if and only if the payload is equal to the correct check digit.
# 
# It was originally posted on reddit.
# 
# Example 1
# 
#     Input: "17893729974"
#     Output: true
# 
#     Payload is 4.
# 
#     Digits from the right:
# 
#     7 * 2 = 14, sum = 5
#     9 = 9
#     9 * 2 = 18, sum = 9
#     2 = 2
#     7 * 2 = 14, sum = 5
#     3 = 3
#     9 * 2 = 18, sum = 9
#     8 = 8
#     7 * 2 = 14, sum = 5
#     1 = 1
# 
#     Sum of all values = 56, so 4 must be added to bring the total mod 10 to zero. The payload is indeed 4.
# 
# Example 2
# 
#     Input: "4137 8947 1175 5904"
#     Output: true
# 
# Example 3
# 
#     Input: "4137 8974 1175 5904"
#     Output: false
# 

package require tcltest

set cases {
    {{17893729974}         1 {Example 1}}
    {{4137 8947 1175 5904} 1 {Example 2}}
    {{4137 8974 1175 5904} 0 {Example 3}}
}

proc luhns_algorithm {num} {

    set num [regsub -all {[^0-9]} $num ""]
    set numl [split $num {}]
    set numllen [llength $numl]

    set sum 0
    for {set i 1} {$i < $numllen} {incr i} {
        if {[expr $i % 2]} {
            set v [expr [lindex $numl end-$i] * 2]
            if {[string length $v] == 2} {
                set sum [expr $sum + [string index $v 0] + [string index $v 1]]
            } else {
                set sum [expr $sum + $v]
            }
        } else {
            set sum [expr $sum + [lindex $numl end-$i]]
        }
    }
    return [expr !(($sum + [lindex $numl end]) % 10)]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       luhns_algorithm [lindex $case 0]
    } [lindex $case 1]
}

exit 0

