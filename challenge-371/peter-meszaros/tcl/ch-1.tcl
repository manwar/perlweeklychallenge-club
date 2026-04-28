#!/usr/bin/env tclsh
#
# Task 1: Missing Letter
# 
# Submitted by: Reinier Maliepaard
# 
# You are given a sequence of 5 lowercase letters, with one letter replaced by
# '?'. Each letter maps to its position in the alphabet ('a = 1', 'b = 2', ... 'z
# = 26'). The sequence follows a repeating pattern of step sizes between
# consecutive letters. The pattern is either a constant step (e.g., '+2, +2, +2,
# +2') or a simple alternating pattern of two distinct steps (e.g., '+2, +3, +2,
# +3').
# 
# Example 1
# 
#     Input: @seq = qw(a c ? g i)
#     Output: e
# 
#     The pattern of the sequence is +2,+2,+2,+2.
#     1: a
#     3: c
#     5: e
#     7: g
#     9: i
# 
# Example 2
# 
#     Input: @seq = qw(a d ? j m)
#     Output: g
# 
#     The pattern of the sequence is +3,+3,+3,+3.
#     1: a
#     4: d
#     7: g
#     10: j
#     13: m
# 
# Example 3
# 
#     Input: @seq = qw(a e ? m q)
#     Output: i
# 
#     The pattern of the sequence is +4,+4,+4,+4.
#     1: a
#     5: e
#     9: i
#     13: m
#     17: q
# 
# Example 4
# 
#     Input: @seq = qw(a c f ? k)
#     Output: h
# 
#     The pattern of the sequence is +2,+3,+2,+3.
#     1: a
#     3: c
#     6: f
#     8: h
#     11: k
# 
# Example 5
# 
#     Input: @seq = qw(b e g ? l)
#     Output: j
# 
#     The pattern of the sequence is +3,+2,+3,+2.
#     2: b
#     5: e
#     7: g
#     10: j
#     12: l
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{a c ? g i} e "Example 1"}
    {{a d ? j m} g "Example 2"}
    {{a e ? m q} i "Example 3"}
    {{a c f ? k} h "Example 4"}
    {{b e g ? l} j "Example 5"}
}

proc missing_letter {seq} {

    set step [expr [scan [lindex $seq 1] %c] - [scan [lindex $seq 0] %c]]
    for {set i 2} {$i < 5} {incr i} {
        if {[lindex $seq $i] eq "?"} {
            return [format %c [expr [scan [lindex $seq [expr $i - 1]] %c] + $step]]
        }
    }
    return ""
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        missing_letter [lindex $case 0]
    } [lindex $case 1]
}

exit 0

