#!/usr/bin/env tclsh
#
# Task 2: Convert Time
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two strings, $source and $target, containing time in 24-hour time
# form.
# 
# Write a script to convert the source into target by performing one of the
# following operations:
# 
#     1. Add  1 minute
#     2. Add  5 minutes
#     3. Add 15 minutes
#     4. Add 60 minutes
# 
# Find the total operations needed to get to the target.
# 
# Example 1
# 
#     Input: $source = "02:30"
#            $target = "02:45"
#     Output: 1
# 
#     Just one operation i.e. "Add 15 minutes".
# 
# Example 2
# 
#     Input: $source = "11:55"
#            $target = "12:15"
#     Output: 2
# 
#     Two operations i.e. "Add 15 minutes" followed by "Add 5 minutes".
# 
# Example 3
# 
#     Input: $source = "09:00"
#            $target = "13:00"
#     Output: 4
# 
#     Four operations of "Add 60 minutes".
# 
# Example 4
# 
#     Input: $source = "23:45"
#            $target = "00:30"
#     Output: 3
# 
#     Three operations of "Add 15 minutes".
# 
# Example 5
# 
#     Input: $source = "14:20"
#            $target = "15:25"
#     Output: 2
# 
#     Two operations, one "Add 60 minutes" and one "Add 5 minutes"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{"02:30" "02:45"} 1 "Example 1"}
    {{"11:55" "12:15"} 2 "Example 2"}
    {{"09:00" "13:00"} 4 "Example 3"}
    {{"23:45" "00:30"} 3 "Example 4"}
    {{"14:20" "15:25"} 2 "Example 5"}
}

proc convert_time {times} {
    set source [lindex $times 0]
    set target [lindex $times 1]

    set sl [split $source ":"]
    set sh [scan [lindex $sl 0] %d]
    set sm [scan [lindex $sl 1] %d]
    set tl [split $target ":"]
    set th [scan [lindex $tl 0] %d]
    set tm [scan [lindex $tl 1] %d]

    set source_mins [expr $sh * 60 + $sm]
    set target_mins [expr $th * 60 + $tm]
    if {$target_mins < $source_mins} {
        set target_mins [expr $target_mins + 24 * 60]
    }
    set diff [expr $target_mins - $source_mins]
    set ops 0
    foreach add {60 15 5 1} {
        while {$diff >= $add} {
            set diff [expr $diff - $add]
            incr ops
        }
    }
    return $ops
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        convert_time [lindex $case 0]
    } [lindex $case 1]
}

exit 0

