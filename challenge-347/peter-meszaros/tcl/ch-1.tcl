#!/usr/bin/env tclsh
#
# Task 1: Format Date
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a date in the form: 10th Nov 2025.
# 
# Write a script to format the given date in the form: 2025-11-10 using the set
# below.
# 
#     @DAYS   = ("1st", "2nd", "3rd", ....., "30th", "31st")
#     @MONTHS = ("Jan", "Feb", "Mar", ....., "Nov",  "Dec")
#     @YEARS  = (1900..2100)
# 
# Example 1
# 
#     Input: $str = "1st Jan 2025"
#     Output: "2025-01-01"
# 
# Example 2
# 
#     Input: $str = "22nd Feb 2025"
#     Output: "2025-02-22"
# 
# Example 3
# 
#     Input: $str = "15th Apr 2025"
#     Output: "2025-04-15"
# 
# Example 4
# 
#     Input: $str = "23rd Oct 2025"
#     Output: "2025-10-23"
# 
# Example 5
# 
#     Input: $str = "31st Dec 2025"
#     Output: "2025-12-31"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"1st Jan 2025"  "2025-01-01" "Example 1"}
    {"22nd Feb 2025" "2025-02-22" "Example 2"}
    {"15th Apr 2025" "2025-04-15" "Example 3"}
    {"23rd Oct 2025" "2025-10-23" "Example 4"}
    {"31st Dec 2025" "2025-12-31" "Example 5"}
}

set DAYS   {"1st" "2nd" "3rd" "4th" "5th" "6th" "7th" "8th" "9th" "10th" \
            "11th" "12th" "13th" "14th" "15th" "16th" "17th" "18th" "19th" "20th" \
            "21st" "22nd" "23rd" "24th" "25th" "26th" "27th" "28th" "29th" "30th" \
            "31st"}
set MONTHS {"Jan" "Feb" "Mar" "Apr" "May" "Jun" \
            "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"}
set DAYMAP {}
set MONTHMAP {}


proc format_date {date} {
    proc init_mappings {} {
        global DAYS MONTHS DAYMAP MONTHMAP

        if {[llength $DAYMAP] > 0} {
            return
        }
        foreach d $DAYS {
            dict set DAYMAP $d [format "%02d" [expr [lsearch -exact $DAYS $d] + 1]]
        }
        foreach m $MONTHS {
            dict set MONTHMAP $m [format "%02d" [expr [lsearch -exact $MONTHS $m] + 1]]
        }
    }
    
    global DAYMAP MONTHMAP 
    init_mappings

    set dlist [split $date " "]
    set d [lindex $dlist 0]
    set m [lindex $dlist 1]
    set y [lindex $dlist 2]

    if {[dict exists $DAYMAP $d] && [dict exists $MONTHMAP $m] && $y >= 1900 && $y <= 2100} {
        return [format "%s-%s-%s" $y [dict get $MONTHMAP $m] [dict get $DAYMAP $d]]
    }
    return ""
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        format_date [lindex $case 0]
    } [lindex $case 1]
}

exit 0

