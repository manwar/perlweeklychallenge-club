#!/usr/bin/env tclsh
#
# Task 1: Replace all ?
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string containing only lower case English letters and ?.
# 
# Write a script to replace all ? in the given string so that the string doesn't
# contain consecutive repeating characters.
# 
# Example 1
# 
#     Input: $str = "a?z"
#     Output: "abz"
# 
#     There can be many strings, one of them is "abz".
#     The choices are 'a' to 'z' but we can't use either 'a' or 'z' to replace
#     the '?'.
# 
# Example 2
# 
#     Input: $str = "pe?k"
#     Output: "peak"
# 
# Example 3
# 
#     Input: $str = "gra?te"
#     Output: "grabte"
# 

package require tcltest

set cases {
    {"a?z"    "abz"    "Example 1"}
    {"pe?k"   "peak"   "Example 2"}
    {"gra?te" "grabte" "Example 3"}
}

proc replace_all_questionmark {str} {
    set chars [split $str ""]
    set len [llength $chars]

    for {set i 0} {$i < $len} {incr i} {
        if {[lindex $chars $i] eq "?"} {
            set used {}
            if {$i > 0 && [lindex $chars [expr {$i - 1}]] ne "?"} {
                lappend used [lindex $chars [expr {$i - 1}]]
            }
            if {$i < $len - 1 && [lindex $chars [expr {$i + 1}]] ne "?"} {
                lappend used [lindex $chars [expr {$i + 1}]]
            }

            for {set o 97} {$o <= 122} {incr o} { # a .. z
                set c [format "%c" $o]
                if {[lsearch -exact $used $c] == -1} {
                    set chars [lreplace $chars $i $i $c]
                    break
                }
            }
        }
    }

    return [join $chars ""]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        replace_all_questionmark [lindex $case 0]
    } [lindex $case 1]
}

exit 0

