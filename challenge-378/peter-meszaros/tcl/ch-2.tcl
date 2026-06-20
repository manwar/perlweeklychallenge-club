#!/usr/bin/env tclsh
#
# Task 2: Sum of Words
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given three strings consisting of lower case English letters 'a' to 'j'
# only. The letter value of a = 0, b = 1, c = 3, etc.  Write a script to find if
# sum of first two strings return the third string.
# 
# Example 1
# 
#     Input: $str1 = "acb", $str2 = "cba", $str3 = "cdb"
#     Output: true
# 
#     $str1 = "acb" = 021
#     $str2 = "cba" = 210
#     $str3 = "cdb" = 231
#     $str1 + $str2 = $str3
# 
# Example 2
# 
#     Input: $str1 = "aab", $str2 = "aac", $str3 = "ad"
#     Output: true
# 
#     $str1 = "aab" = 001
#     $str2 = "aac" = 002
#     $str3 = "ad"  = 03
# 
# Example 3
# 
#     Input: $str1 = "bc", $str2 = "je", $str3 = "jg"
#     Output: false
# 
#     $str1 = "bc" = 12
#     $str2 = "je" = 94
#     $str3 = "jg" = 96
# 
# Example 4
# 
#     Input: $str1 = "a", $str2 = "aaaa", $str3 = "aa"
#     Output: true
# 
#     $str1 = "a"    = 0
#     $str2 = "aaaa" = 0000
#     $str3 = "aa"   = 00
# 
# Example 5
# 
#     Input: $str1 = "c", $str2 = "d", $str3 = "h"
#     Output: false
# 
#     $str1 = "c" = 2
#     $str2 = "d" = 3
#     $str3 = "h" = 7
# 
# Example 6
# 
#     Input: $str1 = "gfi", $str2 = "hbf", $str3 = "bdhd"
#     Output: true
# 
#     $str1 =  "gfi" =  658
#     $str2 =  "hbf" =  715
#     $str3 = "bdhd" = 1373
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{"acb" "cba"  "cdb"} true  "Example 1"}
    {{"aab" "aac"   "ad"} true  "Example 2"}
    {{"bc"   "je"   "jg"} false "Example 3"}
    {{"a"  "aaaa"   "aa"} true  "Example 4"}
    {{"c"     "d"    "h"} false "Example 5"}
    {{"gfi" "hbf" "bdhd"} true  "Example 6"}
}

proc sum_of_words {p} {
    set str1 [lindex $p 0]
    set str2 [lindex $p 1]
    set str3 [lindex $p 2]

    set num1 [join [lmap c [split $str1 {}] {expr [scan $c %c] - 97}] ""]
    set num2 [join [lmap c [split $str2 {}] {expr [scan $c %c] - 97}] ""]
    set num3 [join [lmap c [split $str3 {}] {expr [scan $c %c] - 97}] ""]

    set num1 [scan $num1 "%d"]
    set num2 [scan $num2 "%d"]
    set num3 [scan $num3 "%d"]

    return [expr $num1 + $num2 == $num3 ? true : false]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        sum_of_words [lindex $case 0]
    } [lindex $case 1]
}

exit 0

