#!/usr/bin/env tclsh
#
# Task 1: Make it Bigger
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a given a string number and a character digit.  Write a script to
# remove exactly one occurrence of the given character digit from the given
# string number, resulting the decimal form is maximised.
# 
# Example 1
# 
#     Input: $str = "15456", $char = "5"
#     Output: "1546"
# 
#     Removing the second "5" is better because the digit following it (6) is
#     greater than 5. In the first case, 5 was followed by 4 (a decrease),
#     which makes the resulting number smaller.
# 
# Example 2
# 
#     Input: $str = "7332", $char = "3"
#     Output: "732"
# 
# Example 3
# 
#     Input: $str = "2231", $char = "2"
#     Output: "231"
# 
#     Removing either "2" results in the same string here. By removing a "2",
#     we allow the "3" to move up into a higher decimal place.
# 
# Example 4
# 
#     Input: $str = "543251", $char = "5"
#     Output: "54321"
# 
#     If we remove the first "5", the number starts with 4. If we remove the
#     second "5", the number still starts with 5. Keeping the largest possible
#     digit in the highest place value is almost always the priority.
# 
# Example 5
# 
#     Input: $str = "1921", $char = "1"
#     Output: "921"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{ 15456 5}  1546 "Example 1"}
    {{  7332 3}   732 "Example 2"}
    {{  2231 2}   231 "Example 3"}
    {{543251 5} 54321 "Example 4"}
    {{  1921 1}   921 "Example 5"}
}

proc make_it_bigger {p} {
    set str  [lindex $p 0]
    set char [lindex $p 1]

    set chars [split $str ""]
    set pos -1

    for {set i 0} {$i < [llength $chars]} {incr i} {
        if {[lindex $chars $i] == $char} {
            set pos $i
            if {$i != [expr [llength $chars] - 1] && [string compare [lindex $chars [expr $i + 1]] $char] > 0} {
                set pos $i
                break
            }
        }
    }
    return [join [concat [lrange $chars 0 [expr $pos - 1]] [lrange $chars [expr $pos + 1] end]] ""]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        make_it_bigger [lindex $case 0]
    } [lindex $case 1]
}

exit 0

