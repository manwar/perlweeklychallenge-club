#!/usr/bin/env tclsh
#
# Task 1: Count Vowel
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string. Write a script to return all possible vowel substrings
# in the given string. A vowel substring is a substring that only consists of
# vowels and has all five vowels present in it.
# 
# Example 1
# 
#     Input: $str = "aeiou"
#     Output: ("aeiou")
# 
# Example 2
# 
#     Input: $str = "aaeeeiioouu"
#     Output: ("aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu")
# 
#     NOTE: Updated output [2025-05-18]
# 
# Example 3
# 
#     Input: $str = "aeiouuaxaeiou"
#     Output: ("aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua")
# 
#     NOTE: Updated output [2025-05-18]
# 
# Example 4
# 
#     Input: $str = "uaeiou"
#     Output: ("aeiou", "uaeio", "uaeiou")
# 
# Example 5
# 
#     Input: $str = "aeioaeioa"
#     Output: ()
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"aeiou"         {aeiou}                                       "Example 1"}
    {"aaeeeiioouu"   {aaeeeiioou aaeeeiioouu aeeeiioou aeeeiioouu} "Example 2"}
    {"aeiouuaxaeiou" {aeiou aeiouu aeiouua eiouua aeiou}           "Example 3"}
    {"uaeiou"        {uaeio uaeiou aeiou}                          "Example 4"}
    {"aeioaeioa"     {}                                            "Example 5"}
}

proc count_vowel {str} {
    set results {}

    for {set i 0} {$i < [string length $str]} {incr i} {
        array unset seen
        array set seen {}
        set substr ""

        for {set j $i} {$j < [string length $str]} {incr j} {
            set char [string index $str $j]

            if {[regexp {[aeiou]} $char] == 0} {
                break
            }

            append substr $char
            set seen($char) 1

            if {[array size seen] == 5} {
                lappend results $substr
            }
        }
    }

    return $results
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        count_vowel [lindex $case 0]
    } [lindex $case 1]
}

exit 0

