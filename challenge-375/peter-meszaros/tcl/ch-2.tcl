#!/usr/bin/env tclsh
#
# Task 2: Find K-Beauty
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a number and a digit (k).  Write a script to find the K-Beauty of
# the given number. The K-Beauty of an integer number is defined as the number of
# substrings of given number when it is read as a string has length of 'k' and is
# a divisor of given number.
# 
# Example 1
# 
#     Input: $num = 240, $k = 2
#     Output: 2
# 
#     Substring with length 2:
#     24: 240 is divisible by 24
#     40: 240 is divisible by 40
# 
# Example 2
# 
#     Input: $num = 1020, $k = 2
#     Output: 3
# 
#     Substring with length 2:
#     10: 240 is divisible by 10
#     02: 240 is divisible by 2
#     20: 240 is divisible by 20
# 
# Example 3
# 
#     Input: $num = 444, $k = 2
#     Output: 0
# 
#     Substring with length 2:
#     First "44": 444 is not divisible by 44
#     Second "44": 444 is not divisible by 44
# 
# Example 4
# 
#     Input: $num = 17, $k = 2
#     Output: 1
# 
#     Substring with length 2:
#     17: 17 is divisible by 17
# 
# Example 5
# 
#     Input: $num = 123, $k = 1
#     Output: 2
# 
#     Substring with length 1:
#     1: 123 is divisible by 1
#     2: 123 is not divisible by 2
#     3: 123 is divisible by 3
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{ 240 2} 2 "Example 1"}
    {{1020 2} 3 "Example 2"}
    {{ 444 2} 0 "Example 3"}
    {{  17 2} 1 "Example 4"}
    {{ 123 1} 2 "Example 5"}
}

proc find_k_beauty {p} {
    set num [lindex $p 0]
    set k   [lindex $p 1]

    set count 0
    for {set i 0} {$i <= [string length $num] - $k} {incr i} {
        set substr [string range $num $i [expr $i + $k - 1]]
        if {$substr != 0 && [expr $num % $substr] == 0} {
            incr count
        }
    }
    return $count

}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        find_k_beauty [lindex $case 0]
    } [lindex $case 1]
}

exit 0

