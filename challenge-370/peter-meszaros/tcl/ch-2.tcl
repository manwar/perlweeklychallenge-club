#!/usr/bin/env tclsh
#
# Task 2: Scramble String
# 
# Submitted by: Roger Bell_West
# 
# You are given two strings A and B of the same length.  Write a script to return
# true if string B is a scramble of string A otherwise return false.  String B is
# a scramble of string A if A can be transformed into B by a single (recursive)
# scramble operation.
# 
# A scramble operation is:
# 
#     - If the string consists of only one character, return the string.
#     - Divide the string X into two non-empty parts.
#     - Optionally, exchange the order of those parts.
#     - Optionally, scramble each of those parts.
#     - Concatenate the scrambled parts to return a single string.
# 
# Example 1
# 
#     Input: $str1 = "abc", $str2 = "acb"
#     Output: true
# 
#     "abc"
#     split: ["a", "bc"]
#     split: ["a", ["b", "c"]]
#     swap: ["a", ["c", "b"]]
#     concatenate: "acb"
# 
# Example 2
# 
#     Input: $str1 = "abcd", $str2 = "cdba"
#     Output: true
# 
#     "abcd"
#     split: ["ab", "cd"]
#     swap: ["cd", "ab"]
#     split: ["cd", ["a", "b"]]
#     swap: ["cd", ["b", "a"]]
#     concatenate: "cdba"
# 
# Example 3
# 
#     Input: $str1 = "hello", $str2 = "hiiii"
#     Output: false
# 
#     A fundamental rule of scrambled strings is that they must be anagrams.
# 
# Example 4
# 
#     Input: $str1 = "ateer", $str2 = "eater"
#     Output: true
# 
#     "ateer"
#     split: ["ate", "er"]
#     split: [["at", "e"], "er"]
#     swap: [["e", "at"], "er"]
#     concatenate: "eater"
# 
# Example 5
# 
#     Input: $str1 = "abcd", $str2 = "bdac"
#     Output: false
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{"abc"   "acb"}   true  "Example 1"}
    {{"abcd"  "cdba"}  true  "Example 2"}
    {{"hello" "hiiii"} false "Example 3"}
    {{"ateer" "eater"} true  "Example 4"}
    {{"abcd"  "bdac"}  false "Example 5"}
}

proc scramble_string {p} {
    set str1 [lindex $p 0]
    set str2 [lindex $p 1]

    set m {}

    proc scrambled {s1 s2} {
        global m

        if {[info exists m($s1,$s2)]} {
            return $m($s1,$s2)
        }
        if {[lsort [split $s1 {}]] ne [lsort [split $s2 {}]]} {
            set m($s1,$s2) false
            return false
        }
        if {[string length $s1] == 1} {
            return true
        }

        for {set i 1} {$i < [string length $s1]} {incr i} {
            if {([scrambled [string range $s1 0 [expr $i - 1]]     \
                            [string range $s2 [expr [string length $s2] - $i] end]] && \
                 [scrambled [string range $s1 $i end]              \
                            [string range $s2 0 [expr [string length $s2] - $i - 1]]]) || \
                ([scrambled [string range $s1 0 [expr $i - 1]]     \
                            [string range $s2 0 [expr $i - 1]]] && \
                 [scrambled [string range $s1 $i end]              \
                            [string range $s2 $i end]])} {
                set m($s1,$s2) true
                return true
            }
        }
        set m($s1,$s2) false
        return false
    }
    return [scrambled $str1 $str2]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        scramble_string [lindex $case 0]
    } [lindex $case 1]
}

exit 0

