#!/usr/bin/env tclsh
#
# Task 2: String Difference
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of equal length strings.  Write a script to find the
# difference integer array of each word in the given array. There will be one
# word with a different array; return that word.  Each words[i] can be converted
# into a difference integer array difference[i] of length n - 1 where
# difference[i][j] = words[i][j+1] - words[i][j]
# 
# Example 1
# 
#     Input: @words = ("ab", "bc", "cd", "zy")
#     Output: "zy"
# 
#     "ab" => [1 - 0] = [1]
#     "bc" => [2 - 1] = [1]
#     "cd" => [3 - 2] = [1]
#     "zy" => [24 - 25] = [-1]
# 
# Example 2
# 
#     Input: @words = ("cba", "fed", "azy")
#     Output: "azy"
# 
#     "cba" => [1 - 2, 0 - 1] = [-1, -1]
#     "fed" => [4 - 5, 3 - 4] = [-1, -1]
#     "azy" => [25 - 0, 24 - 25] = [25, -1]
# 
# Example 3
# 
#     Input: @words = ("pop", "ada", "beb", "cfc")
#     Output: "pop"
# 
#     "pop" => [14 - 15, 15 - 14] = [-1, 1]
#     "ada" => [3 - 0, 0 - 3] = [3, -3]
#     "beb" => [4 - 1, 1 - 4] = [3, -3]
#     "cfc" => [5 - 2, 2 - 5] = [3, -3]
# 
# Example 4
# 
#     Input: @words = ("aaaa", "zzzz", "mmmm", "aaba")
#     Output: "aaba"
# 
#     "aaaa" => [0 - 0, 0 - 0, 0 - 0] = [0, 0, 0]
#     "zzzz" => [25 - 25, 25 - 25, 25 - 25] = [0, 0, 0]
#     "mmmm" => [12 - 12, 12 - 12, 12 - 12] = [0, 0, 0]
#     "aaba" => [0 - 0, 1 - 0, 0 - 1] = [0, 1, -1]
# 
# Example 5
# 
#     Input: @words = ("aceg", "bdfh", "cegi", "azbz")
#     Output: "azbz"
# 
#     "aceg" => [2 - 0, 4 - 2, 6 - 4] = [2, 2, 2]
#     "bdfh" => [3 - 1, 5 - 3, 7 - 5] = [2, 2, 2]
#     "cegi" => [4 - 2, 6 - 4, 8 - 6] = [2, 2, 2]
#     "azbz" => [25 - 0, 1 - 25, 25 - 1] = [25, -24, 24]
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{ab bc cd zy}         zy   "Example 1"}
    {{cba fed azy}         azy  "Example 2"}
    {{pop ada beb cfc}     pop  "Example 3"}
    {{aaaa zzzz mmmm aaba} aaba "Example 4"}
    {{aceg bdfh cegi azbz} azbz "Example 5"}
}

proc string_difference {words} {
    array set diffs {}
    foreach word $words {
        set diff {}
        for {set i 0} {$i < [string length $word] - 1} {incr i} {
            lappend diff [expr {[scan [string index $word [expr {$i + 1}]] %c] - 
                                [scan [string index $word $i] %c]}]
        }
        set key [join $diff ,]
        if {[info exists diffs($key)]} {
            set diffs($key) ""
        } else {
            set diffs($key) $word
        }
    }

    foreach key [array names diffs] {
        if {$diffs($key) ne ""} {
            return $diffs($key)
        }
    }
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        string_difference [lindex $case 0]
    } [lindex $case 1]
}

exit 0

