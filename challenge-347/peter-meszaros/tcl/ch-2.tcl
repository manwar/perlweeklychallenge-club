#!/usr/bin/env tclsh
#
# Task 2: Format Phone Number
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a phone number as a string containing digits, space and dash only.
# 
# Write a script to format the given phone number using the below rules:
# 
#     1. Removing all spaces and dashes
#     2. Grouping digits into blocks of length 3 from left to right
#     3. Handling the final digits (4 or fewer) specially:
#        - 2 digits: one block of length 2
#        - 3 digits: one block of length 3
#        - 4 digits: two blocks of length 2
#     4. Joining all blocks with dashes
# 
# Example 1
# 
#     Input: $phone = "1-23-45-6"
#     Output: "123-456"
# 
# Example 2
# 
#     Input: $phone = "1234"
#     Output: "12-34"
# 
# Example 3
# 
#     Input: $phone = "12 345-6789"
#     Output: "123-456-789"
# 
# Example 4
# 
#     Input: $phone = "123 4567"
#     Output: "123-45-67"
# 
# Example 5
# 
#     Input: $phone = "123 456-78"
#     Output: "123-456-78"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"1-23-45-6"   "123-456"     "Example 1"}
    {"1234"        "12-34"       "Example 2"}
    {"12 345-6789" "123-456-789" "Example 3"}
    {"123 4567"    "123-45-67"   "Example 4"}
    {"123 456-78"  "123-456-78"  "Example 5"}
}

proc format_phone_number {phone} {
    regsub -all {[\s-]} $phone {} phone_numbers
    set digits [split $phone_numbers {}]

    set blocks {}
    while {[llength $digits] > 0} {
        set len [llength $digits]
        if {$len == 4} {
            lappend blocks [join [lrange $digits 0 1] ""]
            lappend blocks [join [lrange $digits 2 3] ""]
            set digits [lrange $digits 4 end]
        } elseif {$len == 2} {
            lappend blocks [join [lrange $digits 0 1] ""]
            set digits [lrange $digits 2 end]
        } else {
            lappend blocks [join [lrange $digits 0 2] ""]
            set digits [lrange $digits 3 end]
        }
    }
    return [join $blocks "-"]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        format_phone_number [lindex $case 0]
    } [lindex $case 1]
}

exit 0

