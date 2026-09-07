#!/usr/bin/env tclsh
#
# Task 2: Outermost Parentheses
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a valid parentheses string. Write a script to return the string
# after removing the outermost parentheses of every primitive string in the
# primitive decomposition of the given string.
# 
# Example 1
# 
#     Input: $str = "()()()"
#     Output: ""
# 
#     Primitive Decomposition: "()" + "()" + "()"
# 
# Example 2
# 
#     Input: $str = "(((())))"
#     Output: "((()))"
# 
#     Primitive Decomposition: "(((())))"
# 
# Example 3
# 
#     Input: $str = "(()())(())"
#     Output: "()()()"
# 
#     Primitive Decomposition: "(()())" + "(())"
# 
# Example 4
# 
#     Input: $str = "()((()))()"
#     Output: "(())"
# 
#     Primitive Decomposition: "()" + "((()))" + "()"
# 
# Example 5
# 
#     Input: $str = "(()(()))(()())"
#     Output: "()(())()()"
# 
#     Primitive Decomposition: "(()(()))" + "(()())"
# 

package require Tcl 8.6
package require tcltest

set cases {
    { "()()()"         ""            "Example 1"}
    { "(((())))"       "((()))"      "Example 2"}
    { "(()())(())"     "()()()"      "Example 3"}
    { "()((()))()"     "(())"        "Example 4"}
    { "(()(()))(()())" "()(())()()"  "Example 5"}
}

proc outermost_parentheses {str} {
    set depth 1
    set start 0
    set result ""

    for {set i 1} {$i < [string length $str]} {incr i} {
        set ch [string index $str $i]

        if {$ch eq "("} {
            incr depth
        } elseif {$ch eq ")"} {
            incr depth -1
            if {$depth == 0} {
                set substr [string range $str $start $i]
                set start [expr $i + 1]
                append result [string range $substr 1 end-1]
            }
        }
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        outermost_parentheses [lindex $case 0]
    } [lindex $case 1]
}

exit 0

