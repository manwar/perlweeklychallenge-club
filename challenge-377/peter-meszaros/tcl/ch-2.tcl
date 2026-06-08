#!/usr/bin/env tclsh
#
# Task 2: Prefix Suffix
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of strings.  Write a script to find if the two strings
# (str1, str2) in the given array such that str1 is prefix and suffix of str2.
# Return the total count of such pairs.
# 
# Example 1
# 
#     Input: @array = ("a", "aba", "ababa", "aa")
#     Output: 4
# 
#     $array[0], $array[1]: "a" is a prefix and suffix of "aba"
#     $array[0], $array[2]: "a" is a prefix and suffix of "ababa"
#     $array[0], $array[3]: "a" is a prefix and suffix of "aa"
#     $array[1], $array[2]: "aba" is a prefix and suffix of "ababa"
# 
# Example 2
# 
#     Input: @array = ("pa", "papa", "ma", "mama")
#     Output: 2
# 
#     $array[0], $array[1]: "pa" is a prefix and suffix of "papa"
#     $array[2], $array[3]: "ma" is a prefix and suffix of "mama"
# 
# Example 3
# 
#     Input: @array = ("abao", "ab")
#     Output: 0
# 
# Example 4
# 
#     Input: @array = ("abab", "abab")
#     Output: 1
# 
#     $array[0], $array[1]: "abab" is a prefix and suffix of "abab"
# 
# Example 5
# 
#     Input: @array = ("ab", "abab", "ababab")
#     Output: 3
# 
#     $array[0], $array[1]: "ab" is a prefix and suffix of "abab"
#     $array[0], $array[2]: "ab" is a prefix and suffix of "ababab"
#     $array[1], $array[2]: "abab" is a prefix and suffix of "ababab"
# 
# Example 6
# 
#     Input: @array = ("abc", "def", "ghij")
#     Output: 0
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{"a" "aba" "ababa" "aa"}  4 "Example 1"}
    {{"pa" "papa" "ma" "mama"} 2 "Example 2"}
    {{"abao" "ab"}             0 "Example 3"}
    {{"abab" "abab"}           1 "Example 4"}
    {{"ab" "abab" "ababab"}    3 "Example 5"}
    {{"abc" "def" "ghij"}      0 "Example 6"}
}

proc prefix_suffix {arr} {
    set count 0
    set equals 0

    for {set i 0} {$i < [llength $arr]} {incr i} {
        for {set j 0} {$j < [llength $arr]} {incr j} {
            if {$i == $j} continue
            set str1 [lindex $arr $i]
            set str2 [lindex $arr $j]

            if {[string range $str2 0 [expr [string length $str1] - 1]] eq $str1 &&
                [string range $str2 [expr [string length $str2] - [string length $str1]] end] eq $str1} {
                incr count
                if {$str1 eq $str2} {
                    incr equals
                }
            }
        }
    }
    return [expr $count - int($equals / 2)]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        prefix_suffix [lindex $case 0]
    } [lindex $case 1]
}

exit 0

