#!/usr/bin/env tclsh
#
# Task 2: Backspace Compare
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two strings containing zero or more #.
# 
# Write a script to return true if the two given strings are same by treating #
# as backspace.
# 
# Example 1
# 
#     Input: $str1 = "ab#c"
#            $str2 = "ad#c"
#     Output: true
# 
#     For first string,  we remove "b" as it is followed by "#".
#     For second string, we remove "d" as it is followed by "#".
#     In the end both strings became the same.
# 
# Example 2
# 
#     Input: $str1 = "ab##"
#            $str2 = "a#b#"
#     Output: true
# 
# Example 3
# 
#     Input: $str1 = "a#b"
#            $str2 = "c"
#     Output: false
# 

package require tcltest

set cases {
    {{ab#c ad#c} 1 {Example 1}}
    {{ab## a#b#} 1 {Example 2}}
    {{a#b  c}    0 {Example 3}}
}

proc backspace_compare {strs} {
    set str1 [lindex $strs 0]
    set str2 [lindex $strs 1]

    set regex {[^#]#}

    while {[regsub $regex $str1 {} str1]} {
    }
    while {[regsub $regex $str2 {} str2]} {
    }

    return [expr {$str1 eq $str2}]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       backspace_compare [lindex $case 0]
    } [lindex $case 1]
}

exit 0

