#!/usr/bin/env tclsh
#
# Task 1: Alternate Case
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string containing an equal number of uppercase and lowercase
# English letters.  Write a script to the minimum number of adjacent character
# swaps needed to turn the given string into an alternate case string.
# 
# Example 1
# 
#     Input: $str = "aAbB"
#     Output: 0
# 
# Example 2
# 
#     Input: $str = "AAbb"
#     Output: 1
# 
#     Swap 1: "AbAb"
# 
# Example 3
# 
#     Input: $str = "AAAbbb"
#     Output: 3
# 
#     Swap 1: "AAbAbb"
#     Swap 2: "AbAAbb"
#     Swap 3: "AbAbAb"
# 
# Example 4
# 
#     Input: $str = "aABb"
#     Output: 1
# 
#     Swap 1: "aAbB"
# 
# Example 5
# 
#     Input: $str = "bBBAaa"
#     Output: 2
# 
#     Swap 1: "BbBAaa"
#     Swap 2: "BbBaAa"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"aAbB"   0 "Example 1"}
    {"AAbb"   1 "Example 2"}
    {"AAAbbb" 3 "Example 3"}
    {"aABb"   1 "Example 4"}
    {"bBBAaa" 2 "Example 5"}
}


proc swaps_to_pattern {str start_upper} {
    
    set chars [split $str ""]
    set swaps 0
    set n [llength $chars]

    for {set i 0} {$i < $n} {incr i} {
        set want_upper [expr $i % 2 == 0 ? $start_upper : [expr !$start_upper]]

        set j $i
        while {$j < $n} {
            set is_upper [string is upper [lindex $chars $j]]
            if {$is_upper == $want_upper} {
                break
            }
            incr j
        }

        for {set k $j} {$k > $i} {incr k -1} {
            set temp [lindex $chars $k]
            lset chars $k [lindex $chars [expr $k - 1]]
            lset chars [expr {$k - 1}] $temp
            incr swaps
        }
    }

    return $swaps
}

proc alternate_case {str} {

    set swaps_upper_first [swaps_to_pattern $str 1]
    set swaps_lower_first [swaps_to_pattern $str 0]

    if {$swaps_upper_first < $swaps_lower_first} {
        return $swaps_upper_first
    } else {
        return $swaps_lower_first
    }
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        alternate_case [lindex $case 0]
    } [lindex $case 1]
}

exit 0

