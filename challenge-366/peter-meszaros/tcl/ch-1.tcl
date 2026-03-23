#!/usr/bin/env tclsh
#
# Task 1: Count Prefixes
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of words and a string (contains only lowercase English
# letters).  Write a script to return the number of words in the given array that
# are a prefix of the given string.
# 
# Example 1
# 
#     Input: @array = ("a", "ap", "app", "apple", "banana"), $str = "apple"
#     Output: 4
# 
# Example 2
# 
#     Input: @array = ("cat", "dog", "fish"), $str = "bird"
#     Output: 0
# 
# Example 3
# 
#     Input: @array = ("hello", "he", "hell", "heaven", "he"), $str = "hello"
#     Output: 4
# 
# Example 4
# 
#     Input: @array = ("", "code", "coding", "cod"), $str = "coding"
#     Output: 3
# 
# Example 5
# 
#     Input: @array = ("p", "pr", "pro", "prog", "progr", "progra", "program"), $str = "program"
#     Output: 7
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{{"a" "ap" "app" "apple" "banana"}                    "apple"} 4 "Example 1"}
    {{{"cat" "dog" "fish"}                                  "bird"} 0 "Example 2"}
    {{{"hello" "he" "hell" "heaven" "he"}                  "hello"} 4 "Example 3"}
    {{{"" "code" "coding" "cod"}                          "coding"} 3 "Example 4"}
    {{{"p" "pr" "pro" "prog" "progr" "progra" "program"} "program"} 7 "Example 5"}
}

proc count_prefixes {p} {
    set arr [lindex $p 0]
    set str [lindex $p 1]

    set cnt 0
    foreach w $arr {
        if {[string range $str 0 [expr [string length $w] - 1]] eq $w} {
            incr cnt
        }
    }

    return $cnt
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        count_prefixes [lindex $case 0]
    } [lindex $case 1]
}

exit 0

