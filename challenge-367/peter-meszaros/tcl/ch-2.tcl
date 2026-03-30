#!/usr/bin/env tclsh
#
# Task 2: Conflict Events
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two events start and end time.  Write a script to find out if
# there is a conflict between the two events. A conflict happens when two events
# have some non-empty intersection.
# 
# Example 1
# 
#     Input: @event1 = ("10:00", "12:00")
#            @event2 = ("11:00", "13:00")
#     Output: true
# 
#     Both events overlap from "11:00" to "12:00".
# 
# Example 2
# 
#     Input: @event1 = ("09:00", "10:30")
#            @event2 = ("10:30", "12:00")
#     Output: false
# 
#     Event1 ends exactly at 10:30 when Event2 starts.
#     Since the problem defines intersection as non-empty, exact boundaries
#     touching is not a conflict.
# 
# Example 3
# 
#     Input: @event1 = ("14:00", "15:30")
#            @event2 = ("14:30", "16:00")
#     Output: true
# 
#     Both events overlap from 14:30 to 15:30.
# 
# Example 4
# 
#     Input: @event1 = ("08:00", "09:00")
#            @event2 = ("09:01", "10:00")
#     Output: false
# 
#     There is a 1-minute gap from "09:00" to "09:01".
# 
# Example 5
# 
#     Input: @event1 = ("23:30", "00:30")
#            @event2 = ("00:00", "01:00")
#     Output: true
# 
#     They overlap from "00:00" to "00:30".
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{{"10:00" "12:00"} {"11:00" "13:00"}}  true "Example 1"}
    {{{"09:00" "10:30"} {"10:30" "12:00"}} false "Example 2"}
    {{{"14:00" "15:30"} {"14:30" "16:00"}}  true "Example 3"}
    {{{"08:00" "09:00"} {"09:01" "10:00"}} false "Example 4"}
    {{{"23:30" "00:30"} {"00:00" "01:00"}}  true "Example 5"}
}

proc conflict_events {p} {
    proc time_to_minutes {time} {
        set parts [split $time ":"]
        set h [scan [lindex $parts 0] %d]
        set m [scan [lindex $parts 1] %d]
        return [expr $h * 60 + $m]
    }

    set event1 [lindex $p 0]
    set event2 [lindex $p 1]

    set start1 [time_to_minutes [lindex $event1 0]]
    set end1   [time_to_minutes [lindex $event1 1]]
    set start2 [time_to_minutes [lindex $event2 0]]
    set end2   [time_to_minutes [lindex $event2 1]]

    if {$end1 < $start1} {
        set start1 [expr {$start1 - 24 * 60}]
    }
    if {$end2 < $start2} {
        set start2 [expr {$start2 - 24 * 60}]
    }

    return [expr {($start1 < $end2) && ($start2 < $end1) ? true : false}]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        conflict_events [lindex $case 0]
    } [lindex $case 1]
}

exit 0

