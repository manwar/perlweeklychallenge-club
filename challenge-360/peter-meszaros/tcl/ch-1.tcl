#!/usr/bin/env tclsh
#
# Task 1: Text Justifier
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string and a width.  Write a script to return the string that
# centers the text within that width using asterisks * as padding.
# 
# Example 1
# 
#     Input: $str = "Hi", $width = 5
#     Output: "*Hi**"
# 
#     Text length = 2, Width = 5
#     Need 3 padding characters total
#     Left padding: 1 star, Right padding: 2 stars
# 
# Example 2
# 
#     Input: $str = "Code", $width = 10
#     Output: "***Code***"
# 
#     Text length = 4, Width = 10
#     Need 6 padding characters total
#     Left padding: 3 stars, Right padding: 3 stars
# 
# Example 3
# 
#     Input: $str = "Hello", $width = 9
#     Output: "**Hello**"
# 
#     Text length = 5, Width = 9
#     Need 4 padding characters total
#     Left padding: 2 stars, Right padding: 2 stars
# 
# Example 4
# 
#     Input: $str = "Perl", $width = 4
#     Output: "Perl"
# 
#     No padding needed
# 
# Example 5
# 
#     Input: $str = "A", $width = 7
#     Output: "***A***"
# 
#     Text length = 1, Width = 7
#     Need 6 padding characters total
#     Left padding: 3 stars, Right padding: 3 stars
# 
# Example 6
# 
#     Input: $str = "", $width = 5
#     Output: "*****"
# 
#     Text length = 0, Width = 5
#     Entire output is padding
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{"Hi"    5} "*Hi**"      "Example 1"}
    {{"Code" 10} "***Code***" "Example 2"}
    {{"Hello" 9} "**Hello**"  "Example 3"}
    {{"Perl"  4} "Perl"       "Example 4"}
    {{"A"     7} "***A***"    "Example 5"}
    {{""      5} "*****"      "Example 6"}
}

proc text_justifier {p} {
    set str   [lindex $p 0]
    set width [lindex $p 1]

    set len [string length $str]

    if {$len >= $width} {
        return $str
    }

    set padding  [expr $width - $len]
    set lpadding [expr int($padding / 2)]
    set rpadding [expr $padding - $lpadding]

    return [string repeat "*" $lpadding]$str[string repeat "*" $rpadding]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        text_justifier [lindex $case 0]
    } [lindex $case 1]
}

exit 0

