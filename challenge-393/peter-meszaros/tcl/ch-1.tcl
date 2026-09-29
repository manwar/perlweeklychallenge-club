#!/usr/bin/env tclsh
#
# Task 1: Pythagoras Multiplied
# 
# Submitted by: Ulrich Rieke
# 
# You are given a positive integer n.  Find the number of all positive integer
# triplets (a, b, c) so that a^2 + b^2 = c^2 and a, b and c are integers <= n.
# 
# Example 1
# 
#     Input: $n = 20
#     Output: 12
# 
#     (3,4,5),  (4,3,5),   (5,12,13),(6,8,10),
#     (8,6,10), (8,15,17), (9,12,15),(12,5,13),
#     (12,9,15),(12,16,20),(15,8,17),(16,12,20)
# 
# Example 2
# 
#     Input: $n = 7
#     Output: 2
# 
#     (3,4,5),(4,3,5)
# 
# Example 3
# 
#     Input: $n = 1
#     Output: 0
# 
# Example 4
# 
#     Input: $n = 15
#     Output: 8
# 
# Example 5
# 
#     Input: $n = 30
#     Output: 22
# 

package require Tcl 8.6
package require tcltest

set cases {
    {20 12 "Example 1"}
    { 7  2 "Example 2"}
    { 1  0 "Example 3"}
    {15  8 "Example 4"}
    {30 22 "Example 5"}
}

proc pythagoras_multiplied {n} {
    set count 0
    for {set a 1} {$a <= $n} {incr a} {
        for {set b 1} {$b <= $n} {incr b} {
            set c [expr sqrt($a*$a + $b*$b)]
            if {$c == int($c) && $c <= $n} {
                incr count
            }
        }
    }
    return $count

}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        pythagoras_multiplied [lindex $case 0]
    } [lindex $case 1]
}

exit 0

