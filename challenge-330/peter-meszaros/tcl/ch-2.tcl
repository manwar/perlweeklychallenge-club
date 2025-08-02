#!/usr/bin/env tclsh
#
# Task 2: Title Capital
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string made up of one or more words separated by a single
# space.
# 
# Write a script to capitalise the given title. If the word length is 1 or 2 then
# convert the word to lowercase otherwise make the first character uppercase and
# remaining lowercase.
# 
# Example 1
# 
#     Input: $str = "PERL IS gREAT"
#     Output: "Perl is Great"
# 
# Example 2
# 
#     Input: $str = "THE weekly challenge"
#     Output: "The Weekly Challenge"
# 
# Example 3
# 
#     Input: $str = "YoU ARE A stAR"
#     Output: "You Are a Star"
# 

package require tcltest

set cases {
    {"PERL IS gREAT"        "Perl is Great"        "Example 1"}
    {"THE weekly challenge" "The Weekly Challenge" "Example 2"}
    {"YoU ARE A stAR"       "You Are a Star"       "Example 3"}
}

proc title_capital {str} {
    set words [split $str " "]

    foreach word $words {
        set word [string tolower $word]
        if {[string length $word] > 2} {
            set word "[string toupper [string index $word 0]][string range $word 1 end]"
        }
        lappend w $word
    }
    return [join $w " "]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        title_capital [lindex $case 0]
    } [lindex $case 1]
}

exit 0

