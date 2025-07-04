#!/usr/bin/env tclsh
#
# Task 2: Good String
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string made up of lower and upper case English letters only.
# 
# Write a script to return the good string of the given string. A string is
# called good string if it doesn't have two adjacent same characters, one in
# upper case and other is lower case.
# 
# UPDATE [2025-07-01]: Just to be explicit, you can only remove pair if they are
# same characters, one in lower case and other in upper case, order is not
# important.
# 
# Example 1
# 
#     Input: $str = "WeEeekly"
#     Output: "Weekly"
# 
#     We can remove either, "eE" or "Ee" to make it good.
# 
# Example 2
# 
#     Input: $str = "abBAdD"
#     Output: ""
# 
#     We remove "bB" first: "aAdD"
#     Then we remove "aA": "dD"
#     Finally remove "dD".
# 
# Example 3
# 
#     Input: $str = "abc"
#     Output: "abc"
# 

package require tcltest

set cases {
    {"WeEeekly" "Weekly" "Example 1"}
    {"abBAdD"   ""       "Example 2"}
    {"abc"      "abc"    "Example 3"}
}

proc good_string {str} {
    set stack {}

    foreach char [split $str ""] {
        if {[llength $stack] > 0 && \
            [string tolower $char] eq [string tolower [lindex $stack end]] && \
            $char ne [lindex $stack end]} {
            set stack [lrange $stack 0 end-1]
        } else {
            lappend stack $char
        }
    }

    return [join $stack ""]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        good_string [lindex $case 0]
    } [lindex $case 1]
}

exit 0

