#!/usr/bin/env tclsh
#
# Task 2: Changing Keys
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an alphabetic string, $str, as typed by user.
# 
# Write a script to find the number of times user had to change the key to type
# the given string. Changing key is defined as using a key different from the
# last used key. The shift and caps lock keys won’t be counted.
# 
# =head2 Example 1
# 
#     Input: $str = 'pPeERrLl'
#     Ouput: 3
# 
#     p -> P : 0 key change
#     P -> e : 1 key change
#     e -> E : 0 key change
#     E -> R : 1 key change
#     R -> r : 0 key change
#     r -> L : 1 key change
#     L -> l : 0 key change
# 
# =head2 Example 2
# 
#     Input: $str = 'rRr'
#     Ouput: 0
# 
# =head2 Example 3
# 
#     Input: $str = 'GoO'
#     Ouput: 1
# 

package require tcltest

set cases {
    {pPeERrLl 3 "Example 1"}
    {rRr      0 "Example 2"}
    {GoO      1 "Example 3"}
}

proc changing_keys {str} {
    set l [split [string tolower $str] {}]

    set cnt 0
    for {set i 1} {$i < [llength $l]} {incr i} {
        if {[lindex $l $i] != [lindex $l [expr $i - 1]]} {
            incr cnt
        }
    }

    return $cnt
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        changing_keys [lindex $case 0]
    } [lindex $case 1]
}

exit 0

