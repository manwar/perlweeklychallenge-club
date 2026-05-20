#!/usr/bin/env tclsh
#
# Task 2: Largest Same-digits Number
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string containing 0-9 digits only. Write a script to return
# the largest number with all digits the same in the given string.
# 
# Example 1
# 
#     Input: $str = "6777133339"
#     Output: 3333
# 
# Example 2
# 
#     Input: $str = "1200034"
#     Output: 4
# 
# Example 3
# 
#     Input: $str = "44221155"
#     Output: 55
# 
# Example 4
# 
#     Input: $str = "88888"
#     Output: 88888
# 
# Example 5
# 
#     Input: $str = "11122233"
#     Output: 222
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"6777133339" 3333 "Example 1"}
    {"1200034"       4 "Example 2"}
    {"44221155"     55 "Example 3"}
    {"88888"     88888 "Example 4"}
    {"11122233"    222 "Example 5"}
}

proc largest_same_digits_number {str} {
    set largest 0
    array set digits {}

    foreach d [split $str ""] {
        incr digits($d)
    }

    foreach d [array names digits] {
        set num [string repeat $d $digits($d)]
        if {$num > $largest} {
            set largest $num
        }
    }

    return $largest
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        largest_same_digits_number [lindex $case 0]
    } [lindex $case 1]
}

exit 0

