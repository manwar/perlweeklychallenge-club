#!/usr/bin/env tclsh
#
# Task 1: Match String
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of strings.
# 
# Write a script to return all strings that are a substring of another word in
# the given array in the order they occur.
# 
# Example 1
# 
#     Input: @words = ("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat")
#     Output: ("cat", "dog", "dogcat", "rat")
# 
# Example 2
# 
#     Input: @words = ("hello", "hell", "world", "wor", "ellow", "elloworld")
#     Output: ("hell", "world", "wor", "ellow")
# 
# Example 3
# 
#     Input: @words = ("a", "aa", "aaa", "aaaa")
#     Output: ("a", "aa", "aaa")
# 
# Example 4
# 
#     Input: @words = ("flower", "flow", "flight", "fl", "fli", "ig", "ght")
#     Output: ("flow", "fl", "fli", "ig", "ght")
# 
# Example 5
# 
#     Input: @words = ("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")
#     Output: ("car", "pet", "enter", "pen", "pent")
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{cat cats dog dogcat dogcat rat ratcatdogcat}
        {cat dog dogcat rat}        "Example 1"}
    {{hello hell world wor ellow elloworld}
        {hell world wor ellow}      "Example 2"}
    {{a aa aaa aaaa}
        {a aa aaa}                  "Example 3"}
    {{flower flow flight fl fli ig ght}
        {flow fl fli ig ght}        "Example 4"}
    {{car carpet carpenter pet enter pen pent}
        {car pet enter pen pent}    "Example 5"}
}

proc match_string {words} {
    set result {}
    for {set i 0} {$i < [llength $words]} {incr i} {
        set word_i [lindex $words $i]
        for {set j 0} {$j < [llength $words]} {incr j} {
            if {$i == $j} continue
            set word_j [lindex $words $j]
            if {[string first $word_i $word_j] != -1} {
                lappend result $word_i
                break
            }
        }
    }
    foreach e $result {
        dict set tmp $e 1
    }
    return [dict keys $tmp]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        match_string [lindex $case 0]
    } [lindex $case 1]
}

exit 0

