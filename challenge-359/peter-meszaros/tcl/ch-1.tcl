#!/usr/bin/env tclsh
#
# Task 1: Digital Root
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a positive integer, $int.  Write a function that calculates the
# additive persistence of a positive integer and also return the digital root.
# Digital root is the recursive sum of all digits in a number until a single
# digit is obtained. Additive persistence is the number of times you need to sum
# the digits to reach a single digit.
# 
# Example 1
# 
#     Input: $int = 38
#     Output: Persistence  = 2
#         Digital Root = 2
# 
#     38 => 3 + 8 => 11
#     11 => 1 + 1 => 2
# 
# Example 2
# 
#     Input: $int = 7
#     Output: Persistence  = 0
#             Digital Root = 7
# 
# Example 3
# 
#     Input: $int = 999
#     Output: Persistence  = 2
#             Digital Root = 9
# 
#     999 => 9 + 9 + 9 => 27
#     27  => 2 + 7 => 9
# 
# Example 4
# 
#     Input: $int = 1999999999
#     Output: Persistence  = 3
#             Digital Root = 1
# 
#     1999999999 => 1 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 => 82
#     82 => 8 + 2 => 10
#     10 => 1 + 0 => 1
# 
# Example 5
# 
#     Input: $int = 101010
#     Output: Persistence  = 1
#             Digital Root = 3
# 
#     101010 => 1 + 0 + 1 + 0 + 1 + 0 => 3
# 

package require Tcl 8.6
package require tcltest

set cases {
    {        38 {2 2} "Example 1"}
    {         7 {0 7} "Example 2"}
    {       999 {2 9} "Example 3"}
    {1999999999 {3 1} "Example 4"}
    {    101010 {1 3} "Example 5"}
}

proc digital_root {int} {
    set persistence 0

    while {$int > 9} {
        set digits [split [string map {{} {}} $int] ""]
        set int 0
        foreach d $digits {
            set int [expr $int + $d]
        }
        incr persistence
    }

    return [list $persistence $int]

}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        digital_root [lindex $case 0]
    } [lindex $case 1]
}

exit 0

