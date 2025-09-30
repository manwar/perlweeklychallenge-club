#!/usr/bin/env tclsh
#
# Task 1: Broken Keyboard
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string containing English letters only and also you are given
# broken keys.
# 
# Write a script to return the total words in the given sentence can be typed
# completely.
# 
# Example 1
# 
#     Input: $str = 'Hello World', @keys = ('d')
#     Output: 1
# 
#     With broken key 'd', we can only type the word 'Hello'.
# 
# Example 2
# 
#     Input: $str = 'apple banana cherry', @keys = ('a', 'e')
#     Output: 0
# 
# Example 3
# 
#     Input: $str = 'Coding is fun', @keys = ()
#     Output: 3
# 
#     No keys broken.
# 
# Example 4
# 
#     Input: $str = 'The Weekly Challenge', @keys = ('a','b')
#     Output: 2
# 
# Example 5
# 
#     Input: $str = 'Perl and Python', @keys = ('p')
#     Output: 1
# 

package require tcltest

set cases {
    {{"Hello World"          {d}}   1 "Example 1"}
    {{"apple banana cherry"  {a e}} 0 "Example 2"}
    {{"Coding is fun"        {}}    3 "Example 3"}
    {{"The Weekly Challenge" {a b}} 2 "Example 4"}
    {{"Perl and Python"      {p}}   1 "Example 5"}
}

proc broken_keyboard {p} {
    set str  [lindex $p 0]
    set keys [lindex $p 1]

    foreach k $keys {
        regsub -all -nocase $k $str "#" str
    }
    set count 0
    foreach w [split $str] {
        if {[string first "#" $w] == -1} {
            incr count
        }
    }
    return $count
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        broken_keyboard [lindex $case 0]
    } [lindex $case 1]
}

exit 0

