#!/usr/bin/env tclsh
#
# Task 2: Find Third
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a sentence and two words.
# 
# Write a script to return all words in the given sentence that appear in
# sequence to the given two words.
# 
# Example 1
# 
#     Input: $sentence = "Perl is a my favourite language but Python is my favourite too."
#            $first = "my"
#            $second = "favourite"
#     Output: ("language", "too")
# 
# Example 2
# 
#     Input: $sentence = "Barbie is a beautiful doll also also a beautiful princess."
#            $first = "a"
#            $second = "beautiful"
#     Output: ("doll", "princess")
# 
# Example 3
# 
#     Input: $sentence = "we will we will rock you rock you.",
#            $first = "we"
#            $second = "will"
#     Output: ("we", "rock")
# 

package require tcltest

set cases {
    {{"Perl is a my favourite language but Python is my favourite too." my favourite}
            {language too} "Example 1"}
    {{"Barbie is a beautiful doll also also a beautiful princess." a beautiful}
            {doll princess} "Example 2"}
    {{"we will we will rock you rock you." we will}
            {we rock} "Example 3"}
}

proc find_third {p} {
    set sentence [lindex $p 0]
    set first    [lindex $p 1]
    set second   [lindex $p 2]

    set sentence [regsub -all {[[:punct:]]} $sentence ""]
    set words [split $sentence]
    set result {}
    for {set i 0} {$i < [llength $words] - 1} {incr i} {
        if {[lindex $words $i] eq $first && [lindex $words $i+1] eq $second} {
            lappend result [lindex $words $i+2]
        }
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        find_third [lindex $case 0]
    } [lindex $case 1]
}

exit 0

