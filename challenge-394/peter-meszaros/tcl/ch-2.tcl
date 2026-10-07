#!/usr/bin/env tclsh
#
# Task 2: Alternating Vowels Consonants
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given three strings containing English alphabetic characters.  Find all
# the longest contiguous substrings common to all three strings that strictly
# alternate between vowels and consonants.
# 
# Example 1
# 
#     Input: @str = ("relocate", "delocate", "allocate")
#     Output: ("locate")
# 
# Example 2
# 
#     Input: @str = ("apple", "banana", "cherry")
#     Output: ()
# 
# Example 3
# 
#     Input: @str = ("navigate", "cavity", "gravity")
#     Output: ("avi")
# 
# Example 4
# 
#     Input: @str = ("pedalgia", "pedalboard", "pedantic")
#     Output: ("peda")
# 
# Example 5
# 
#     Input: @strings = ("schoolmaster", "schoolhouse", "schooling")
#     Output: ("ho", "ol")
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{relocate     delocate    allocate}  {locate} "Example 1"}
    {{apple        banana      cherry}    {}       "Example 2"}
    {{navigate     cavity      gravity}   {avi}    "Example 3"}
    {{pedalgia     pedalboard  pedantic}  {peda}   "Example 4"}
    {{schoolmaster schoolhouse schooling} {ho ol}  "Example 5"}
}

proc is_vowel {c} {
    return [regexp {[aeiouAEIOU]} $c]
}

proc alternating_substrings {s} {
    array set result {}
    set n [string length $s]

    for {set i 0} {$i < $n} {incr i} {
       set sub [string index $s $i]
       set result($sub) 1

        for {set j [expr $i + 1]} {$j < $n} {incr j} {
            if {[is_vowel [string index $s $j]] == [is_vowel [string index $s [expr $j - 1]]]} {
                break
            }
            append sub [string index $s $j]
            set result($sub) 1
        }
    }

    return [array names result]
}

proc alternating_vowels_consonants {str} {
    set as1 [alternating_substrings [lindex $str 0]]
    set as2 [alternating_substrings [lindex $str 1]]
    set as3 [alternating_substrings [lindex $str 2]]

    array set common {}
    foreach s $as1 {
        if {[lsearch -exact $as2 $s] != -1 && [lsearch -exact $as3 $s] != -1} {
            set common($s) 1
        }
    }

    set max_len 0
    foreach s [array names common] {
        set len [string length $s]
        if {$len > $max_len} {
            set max_len $len
        }
    }

    set answer {}
    foreach s [array names common] {
        if {[string length $s] == $max_len} {
            lappend answer $s
        }
    }

    return [lsort $answer]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        alternating_vowels_consonants [lindex $case 0]
    } [lindex $case 1]
}

exit 0

