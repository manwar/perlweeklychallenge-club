#!/usr/bin/env tclsh
#
# Task 2: Reverse Letters
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string.
# 
# Write a script to reverse only the alphabetic characters in the string.
# 
# Example 1
# 
#     Input: $str = "p-er?l"
#     Output: "l-re?p"
# 
# Example 2
# 
#     Input: $str = "wee-k!L-y"
#     Output: "yLk-e!e-w"
# 
# Example 3
# 
#     Input: $str = "_c-!h_all-en!g_e"
#     Output: "_e-!g_nel-la!h_c"
# 

package require tcltest

set cases {
    {"p-er?l"           "l-re?p"           "Example 1"}
    {"wee-k!L-y"        "yLk-e!e-w"        "Example 2"}
    {"_c-!h_all-en!g_e" "_e-!g_nel-la!h_c" "Example 3"}
}

proc reverse_letters {str} {
    set chars [split $str ""]

    set alphas [lmap v $chars { if {![string is alpha $v]} continue 
                                set v 
               }]
    set reversed [lreverse $alphas]

    for {set i 0} {$i < [llength $chars]} {incr i} {
        if {[regexp -nocase {^[a-z]$} [lindex $chars $i]]} {
            lset chars $i [lindex $reversed 0]
            set reversed [lrange $reversed 1 end]
        }
    }
    return [join $chars ""]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        reverse_letters [lindex $case 0]
    } [lindex $case 1]
}

exit 0

