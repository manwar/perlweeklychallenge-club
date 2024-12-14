#!/usr/bin/env tclsh
#
# Task 1: Replace Words
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of words and a sentence.
# 
# Write a script to replace all words in the given sentence that start with any
# of the words in the given array.
# 
# Example 1
# 
#     Input: @words = ("cat", "bat", "rat")
#            $sentence = "the cattle was rattle by the battery"
#     Output: "the cat was rat by the bat"
# 
# Example 2
# 
#     Input: @words = ("a", "b", "c")
#            $sentence = "aab aac and cac bab"
#     Output: "a a a c b"
# 
# Example 3
# 
#     Input: @words = ("man", "bike")
#            $sentence = "the manager was hit by a biker"
#     Output: "the man was hit by a bike"
# 

package require tcltest

set cases {
    {{{cat bat rat} {the cattle was rattle by the battery}} {the cat was rat by the bat} "Example 1"}
    {{{a   b   c}   {aab aac and cac bab}}                  {a a a c b}                  "Example 2"}
    {{{man bike}    {the manager was hit by a biker}}       {the man was hit by a bike}  "Example 3"}
}


proc replace_words {p} {
    set words    [lindex $p 0]
    set sentence [lindex $p 1]

    set sentence_list [split $sentence " "]

    for {set i 0} {$i < [llength $sentence_list]} {incr i} {
        foreach w $words {
            if {[regexp "^$w" [lindex $sentence_list $i]]} {
                lset sentence_list $i $w
            }
        }
    }

    return [join $sentence_list " "]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       replace_words [lindex $case 0]
    } [lindex $case 1]
}

exit 0

