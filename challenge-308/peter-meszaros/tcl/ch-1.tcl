#!/usr/bin/env tclsh
#
# Task 1: Count Common
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two array of strings, @str1 and @str2.
# 
# Write a script to return the count of common strings in both arrays.
# 
# Example 1
# 
#     Input: @str1 = ("perl", "weekly", "challenge")
#            @str2 = ("raku", "weekly", "challenge")
#     Output: 2
# 
# Example 2
# 
#     Input: @str1 = ("perl", "raku", "python")
#            @str2 = ("python", "java")
#     Output: 1
# 
# Example 3
# 
#     Input: @str1 = ("guest", "contribution")
#            @str2 = ("fun", "weekly", "challenge")
#     Output: 0
# 

package require tcltest

set cases {
    {{{perl  weekly challenge} {raku   weekly challenge}} 2 "Example 1"}
    {{{perl  raku   python}    {python java}}             1 "Example 2"}
    {{{guest contribution}     {fun    weekly challenge}} 0 "Example 3"}
}

proc count_common {p} {
    set str1 [lindex $p 0]
    set str2 [lindex $p 1]

    set l [concat {*}[lmap x $str1 {list $x 1}]]
    set h1 [dict create {*}$l]

    set cnt 0
    foreach s $str2 {
        if {[dict exists $h1 $s]} {
            incr cnt
        }
    }
    return $cnt
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       count_common [lindex $case 0]
    } [lindex $case 1]
}

exit 0

