#!/usr/bin/env tclsh
#
# Task 1: Uncommon Words
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two sentences.  Write a script to return list of all uncommon
# words, order is not important.
# 
# Example 1
# 
#     Input: $sentence1 = "apple banana apple"
#            $sentence2 = "banana orange"
#     Output: ("orange")
# 
# Example 2
# 
#     Input: $sentence1 = "cat dog"
#            $sentence2 = "bird fish"
#     Output: ("cat", "dog", "bird", "fish")
# 
# Example 3
# 
#     Input: $sentence1 = "the quick brown fox"
#            $sentence2 = "the quick"
#     Output: ("brown", "fox")
# 
# Example 4
# 
#     Input: $sentence1 = "hello"
#            $sentence2 = "hello"
#     Output: ()
# 
# Example 5
# 
#     Input: $sentence1 = "blue blue red"
#            $sentence2 = "red green green yellow"
#     Output: ("yellow")
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{"apple banana apple" "banana orange"}     {orange}            "Example 1"}
    {{"cat dog" "bird fish"}                    {bird cat dog fish} "Example 2"}
    {{"the quick brown fox" "the quick"}        {brown fox}         "Example 3"}
    {{"hello" "hello"}                          {}                  "Example 4"}
    {{"blue blue red" "red green green yellow"} {yellow}            "Example 5"}
}

proc uncommon_words {p} {
    set sentence1 [lindex $p 0]
    set sentence2 [lindex $p 1]
    set words1 [split $sentence1]
    set words2 [split $sentence2]
    array set count {}
    foreach word [concat $words1 $words2] {
        if {[info exists count($word)]} {
            incr count($word)
        } else {
            set count($word) 1
        }
    }
    set result {}
    foreach word [array names count] {
        if {$count($word) == 1} {
            lappend result $word
        }
    }   
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        lsort [uncommon_words [lindex $case 0]]
    } [lindex $case 1]
}

exit 0

