#!/usr/bin/env tclsh
#
# Task 1: Twice Appearance
#
# Submitted by: Mohammad Sajid Anwar
#
# You are given a string, $str, containing lowercase English letters only.
#
# Write a script to print the first letter that appears twice.
#
# Example 1
#
#	Input: $str = "acbddbca"
#	Output: "d"
#
# Example 2
#
#	Input: $str = "abccd"
#	Output: "c"
#
# Example 3
#
#	Input: $str = "abcdabbb"
#	Output: "a"
#

package require tcltest

set cases {
	{acbddbca d    "Example 1"}
	{abccd    c    "Example 2"}
	{abcdabbb a    "Example 3"}
	{abcdxy   null "Example 4"}
}

proc twice_apperance {str} {
    set d [dict create]
    foreach c [split $str {}] {
        if {[dict exists $d $c]} {
            return $c
        } else {
            dict set d $c 1
        }
    }
    return null
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        twice_apperance [lindex $case 0]
    } [lindex $case 1]
}

exit 0

