#!/usr/bin/env tclsh
#
# Task 2: Count Asterisks
#
# Submitted by: Mohammad Sajid Anwar
#
# You are given a string, $str, where every two consecutive vertical bars are
# grouped into a pair.
#
# Write a script to return the number of asterisks, *, excluding any between each
# pair of vertical bars.
#
# Example 1
#
#	Input: $str = "p|*e*rl|w**e|*ekly|"
#	Ouput: 2
#
# characters we are looking here are "p" and "w**e".
#
# Example 2
#
#	Input: $str = "perl"
#	Ouput: 0
#
# Example 3
#
#	Input: $str = "th|ewe|e**|k|l***ych|alleng|e"
#	Ouput: 5
#
# The characters we are looking here are "th", "e**", "l***ych" and "e".
#

package require tcltest

set cases {
	{"gp|*e*rl|w**e|*ekly|"           2 "Example 1"}
	{"gperl"                          0 "Example 2"}
	{"gth|ewe|e**|k|l***ych|alleng|e" 5 "Example 3"}
}

proc count_asterisks {str} {

    set count 0
    foreach {even odd} [split $str "|"] {
        incr count [regexp -all {\*} $even]
    }
    return $count
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        count_asterisks [lindex $case 0]
    } [lindex $case 1]
}

exit 0

