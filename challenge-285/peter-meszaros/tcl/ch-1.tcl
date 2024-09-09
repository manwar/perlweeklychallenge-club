#!/usr/bin/env tclsh
#
# Task 1: No Connection
#
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of routes, @routes.
# 
# Write a script to find the destination with no further outgoing connection.
# 
# Example 1
# 
#     Input: @routes = (["B","C"], ["D","B"], ["C","A"])
#     Output: "A"
# 
#     "D" -> "B" -> "C" -> "A".
#     "B" -> "C" -> "A".
#     "C" -> "A".
#     "A".
# 
# Example 2
# 
#     Input: @routes = (["A","Z"])
#     Output: "Z"
# 

package require tcltest

set cases {
    {{{"B" "C"} {"D" "B"} {"C" "A"}} "A" "Example 1"}
    {{{"A" "Z"}                    } "Z" "Example 2"}
}

proc no_connection {branches} {
    foreach br $branches {
        lappend e [lindex $br 0]
        dict append s [lindex $br 1] 1
    }
    set s [dict remove $s {*}$e]
    return [dict keys $s]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        no_connection [lindex $case 0]
    } [lindex $case 1]
}

exit 0
