#!/usr/bin/env tclsh
#
# Task 2: Meeting Point
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given instruction string made up of U (up), D (down), L (left) and R
# (right).
# 
# Write a script to return true if following the instruction, you meet (0,0) at
# any point along the sequence.
# 
# Example 1
# 
#     Input: $path = "ULD"
#     Output: false
# 
#     (-1,1) <- (0,1)
#        |        ^
#        v        |
#     (-1,0)    (0,0)
# 
# Example 2
# 
#     Input: $path = "ULDR"
#     Output: true
# 
#     (-1,1) <- (0,1)
#        |        ^
#        v        |
#     (-1,0) -> (0,0)
# 
# Example 3
# 
#     Input: $path = "UUURRRDDD"
#     Output: false
# 
#     (0,3) -> (1,3) -> (2,3) -> (3,3)
#       ^                          |
#       |                          v
#     (0,2)                      (3,2)
#       ^                          |
#       |                          v
#     (0,1)                      (3,1)
#       ^                          |
#       |                          v
#     (0,0)                      (3,0)
# 
# Example 4
# 
#     Input: $path = "UURRRDDLLL"
#     Output: true
# 
#     (0,2) -> (1,2) -> (2,2) -> (3,2)
#       ^                          |
#       |                          v
#     (0,1)                      (3,1)
#       ^                          |
#       |                          v
#     (0,0) <- (1,0) <- (1,1) <- (3,0)
# 
# Example 5
# 
#     Input: $path = "RRUULLDDRRUU"
#     Output: true
# 
#     (0,2) <- (1,2) <- (2,2)
#       |                 ^
#       v                 |
#     (0,1)             (2,1)
#       |                 ^
#       v                 |
#     (0,0) -> (1,0) -> (2,1)
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"ULD"          0 "Example 1"}
    {"ULDR"         1 "Example 2"}
    {"UUURRRDDD"    0 "Example 3"}
    {"UURRRDDLLL"   1 "Example 4"}
    {"RRUULLDDRRUU" 1 "Example 5"}
}

proc meeting_point {path} {
    set x 0
    set y 0
    foreach move [split $path ""] {
        switch $move {
            U { incr y }
            D { incr y -1 }
            L { incr x -1 }
            R { incr x }
        }
        if {$x == 0 && $y == 0} {
            return 1
        }
    }
    return 0
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        meeting_point [lindex $case 0]
    } [lindex $case 1]
}

exit 0

