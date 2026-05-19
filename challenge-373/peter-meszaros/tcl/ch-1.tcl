#!/usr/bin/env tclsh
#
# Task 1: Equal List
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two arrays of strings.  Write a script to return true if the two
# given array represent the same strings otherwise false.
# 
# Example 1
# 
#     Input: @arr1 = ("a", "bc")
#            @arr2 = ("ab", "c")
#     Output: true
# 
#     Array 1: "a" + "bc" = "abc"
#     Array 2: "ab" + "c" = "abc"
# 
# Example 2
# 
#     Input: @arr1 = ("a", "b", "c")
#            @arr2 = ("a", "bc")
#     Output: true
# 
#     Array 1: "a" + "b" + "c" = "abc"
#     Array 2: "a" + "bc" = "abc"
# 
# Example 3
# 
#     Input: @arr1 = ("a", "bc")
#            @arr2 = ("a", "c", "b")
#     Output: false
# 
#     Array 1: "a" + "bc" = "abc"
#     Array 2: "a" + "c" + "b" = "acb"
# 
# Example 4
# 
#     Input: @arr1 = ("ab", "c", "")
#            @arr2 = ("", "a", "bc")
#     Output: true # 
#     Array 1: "ab" + "c" + "" = "abc"
#     Array 2: ""  + "a" + "bc" = "abc"
# 
# Example 5
# 
#     Input: @arr1 = ("p", "e", "r", "l")
#            @arr2 = ("perl")
#     Output: true
# 
#     Array 1: "p" + "e" + "r" + "l" = "perl"
#     Array 2: "perl"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{{"a" "bc"}        {"ab" "c"}}    true  "Example 1"}
    {{{"a" "b" "c"}     {"a" "bc"}}    true  "Example 2"}
    {{{"a" "bc"}        {"a" "c" "b"}} false "Example 3"}
    {{{"ab" "c" ""}     {"" "a" "bc"}} true  "Example 4"}
    {{{"p" "e" "r" "l"} {"perl"}}      true  "Example 5"}
}

proc equal_list {arr} {
    if {[join [lindex $arr 0] ""] == [join [lindex $arr 1] ""]} {
        return true
    } else {
        return false
    }
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        equal_list [lindex $case 0]
    } [lindex $case 1]
}

exit 0

