#!/usr/bin/env tclsh
#
# Task 2: Find Anagrams
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of words, @words.
# 
# Write a script to find any two consecutive words and if they are anagrams, drop
# the first word and keep the second. You continue this until there is no more
# anagrams in the given list and return the count of final list.
# 
# Example 1
# 
#     Input: @words = ("acca", "dog", "god", "perl", "repl")
#     Output: 3
# 
#     Step 1: "dog" and "god" are anagrams, so dropping "dog" and keeping "god" => ("acca", "god", "perl", "repl")
#     Step 2: "perl" and "repl" are anagrams, so dropping "perl" and keeping "repl" => ("acca", "god", "repl")
# 
# Example 2
# 
#     Input: @words = ("abba", "baba", "aabb", "ab", "ab")
#     Output: 2
# 
#     Step 1: "abba" and "baba" are anagrams, so dropping "abba" and keeping "baba" => ("baba", "aabb", "ab", "ab")
#     Step 2: "baba" and "aabb" are anagrams, so dropping "baba" and keeping "aabb" => ("aabb", "ab", "ab")
#     Step 3: "ab" and "ab" are anagrams, so dropping "ab" and keeping "ab" => ("aabb", "ab")
# 

package require tcltest

set cases {
    {{"acca" "dog" "god" "perl" "repl"} 3 "Example 1"}
    {{"abba" "baba" "aabb" "ab" "ab"}   2 "Example 2"}
}

proc find_anagrams {l} {
    set sorted [lmap w $l {join [lsort [split $w ""]] ""}]
    for {set i 0} {$i < [llength $l]-1} {incr i} {
        if {[lindex $sorted $i] eq [lindex $sorted [expr {$i+1}]]} {
            lset l $i {}
        }
    }
    return [llength [lsearch -all -inline -not -exact $l {}]]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       find_anagrams [lindex $case 0]
    } [lindex $case 1]
}

exit 0

