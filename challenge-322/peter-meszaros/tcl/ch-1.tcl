#!/usr/bin/env tclsh
#
# Task 1: String Format
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string and a positive integer.
# 
# Write a script to format the string, removing any dashes, in groups of size
# given by the integer. The first group can be smaller than the integer but
# should have at least one character. Groups should be separated by dashes.
# 
# Example 1
# 
#     Input: $str = "ABC-D-E-F", $i = 3
#     Output: "ABC-DEF"
# 
# Example 2
# 
#     Input: $str = "A-BC-D-E", $i = 2
#     Output: "A-BC-DE"
# 
# Example 3
# 
#     Input: $str = "-A-B-CD-E", $i = 4
#     Output: "A-BCDE"
# 

package require tcltest

set cases {
    {{ABC-D-E-F 3} ABC-DEF {Example 1}}
    {{A-BC-D-E  2} A-BC-DE {Example 2}}
    {{-A-B-CD-E 4} A-BCDE  {Example 3}}
}

proc string_format {p} {
    set str [lindex $p 0]
    set i   [lindex $p 1]

    regsub -all {\-} $str {} str

    set res {}
    set l [string length $str]
    while {$l > 0} {
        set s [string range $str [expr $l - $i] end]
        set str [string replace $str [expr $l - $i] end {}]
        set l [string length $str]
        if {[string length $s] > 0} {
            set res [linsert $res 0 $s]
        }
    }

    return [join $res -]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       string_format [lindex $case 0]
    } [lindex $case 1]
}

exit 0

