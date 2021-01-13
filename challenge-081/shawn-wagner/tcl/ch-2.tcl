#!/usr/bin/env tclsh

proc task2 {input} {
    set fp [open $input]
    while {[gets $fp line] >= 0} {
        regsub -all {[.""(),]|--|'s} $line "" line
        foreach word [split $line] {
            dict incr words $word
        }
    }
    close $fp
    dict for {word count} $words {
        dict lappend frequencies $count $word
    }
    foreach count [lsort -integer [dict keys $frequencies]] {
        puts "$count [lsort [dict get $frequencies $count]]"
    }
}

task2 input
