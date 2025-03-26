#!/usr/bin/env tclsh
#
# Task 2: Sort Column
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of strings of same length.
# 
# Write a script to make each column sorted lexicographically by deleting any non
# sorted columns.
# 
# Return the total columns deleted.
# 
# Example 1
# 
#     Input: @list = ("swpc", "tyad", "azbe")
#     Output: 2
# 
#     swpc
#     tyad
#     azbe
# 
#     Column 1: "s", "t", "a" => non sorted
#     Column 2: "w", "y", "z" => sorted
#     Column 3: "p", "a", "b" => non sorted
#     Column 4: "c", "d", "e" => sorted
# 
# Total columns to delete to make it sorted lexicographically.
# 
# Example 2
# 
#     Input: @list = ("cba", "daf", "ghi")
#     Output: 1
# 
# Example 3
# 
#     Input: @list = ("a", "b", "c")
#     Output: 0
# 

package require tcltest

set cases {
    {{"swpc" "tyad" "azbe"} 2 "Example 1"}
    {{ "cba"  "daf"  "ghi"} 1 "Example 2"}
    {{   "a"    "b"    "c"} 0 "Example 3"}
}

proc sort_column {l} {
    foreach w $l {
        set chars [split $w ""]
        for {set i 0} {$i < [llength $chars]} {incr i} {
            lappend col($i) [lindex $chars $i]
        }
    }
    set delete 0
    for {set i 0} {$i < [array size col]} {incr i} {
        set srtd [join [lsort $col($i)] ""]
        set orig [join $col($i) ""]
        if {$srtd ne $orig} {
            incr delete
        }
    }
    return $delete
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        sort_column [lindex $case 0]
    } [lindex $case 1]
}

exit 0

