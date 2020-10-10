#!/usr/bin/env tclsh

proc substrings {s} {
    set len [string length $s]
    for {set start 0} {$start < $len} {incr start} {
        for {set end $start} {$end < $len} {incr end} {
            dict set substrings [string range $s $start $end] 1
        }
    }
    return [dict keys $substrings]
}

proc task1 {A B} {
    foreach substr [concat [substrings $A] [substrings $B]] {
        dict incr subs $substr
    }
    dict for {substr count} $subs {
        if {$count != 2} { continue }
        if {[regexp "^(?:$substr)+$" $A] && [regexp "^(?:$substr)+$" $B]} {
            lappend common $substr
        }
    }
    puts [lsort $common]
}

task1 abcdabcd abcdabcdabcdabcd
task1 aaa aa
