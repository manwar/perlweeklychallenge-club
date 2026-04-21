#!/usr/bin/env tclsh
#
# Task 2: Group Division
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, group size and filler character.  Write a script to
# divide the string into groups of given size. In the last group if the string
# doesn't have enough characters remaining fill with the given filler character.
# 
# Example 1
# 
#     Input: $str = "RakuPerl", $size = 4, $filler = "*"
#     Output: ("Raku", "Perl")
# 
# Example 2
# 
#     Input: $str = "Python", $size = 5, $filler = "0"
#     Output: ("Pytho", "n0000")
# 
# Example 3
# 
#     Input: $str = "12345", $size = 3, $filler = "x"
#     Output: ("123", "45x")
# 
# Example 4
# 
#     Input: $str = "HelloWorld", $size = 3, $filler = "_"
#     Output: ("Hel", "loW", "orl", "d__")
# 
# Example 5
# 
#     Input: $str = "AI", $size = 5, $filler = "!"
#     Output: "AI!!!"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{RakuPerl   4 *} {Raku Perl}       "Example 1"}
    {{Python     5 0} {Pytho n0000}     "Example 2"}
    {{12345      3 x} {123 45x}         "Example 3"}
    {{HelloWorld 3 _} {Hel loW orl d__} "Example 4"}
    {{AI         5 !} {AI!!!}           "Example 5"}
}

proc group_division {p} {
    set str    [lindex $p 0]
    set size   [lindex $p 1]
    set filler [lindex $p 2]

    set result {}
    while {[string length $str] > 0} {
        set group [string range $str 0 [expr $size - 1]]
        set str   [string range $str $size end]
        if {[string length $group] < $size} {
            append group [string repeat $filler [expr $size - [string length $group]]]
        }
        lappend result $group
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        group_division [lindex $case 0]
    } [lindex $case 1]
}

exit 0

