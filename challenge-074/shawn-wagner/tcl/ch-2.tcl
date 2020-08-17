#!/usr/bin/env tclsh

# Same approach as the perl version.
# tcl dicts preserve order of keys, making it easy.

proc lshift {lstv} {
    upvar 1 $lstv lst
    set lst [lreplace $lst 0 0]
}

proc task2 {S} {
    set S [lreverse [split $S ""]]
    while {[llength $S] > 0} {
        foreach elem $S {
            dict incr counts $elem
        }
        set found false
        dict for {char count} $counts {
            if {$count == 1} {
                set found true
                append res $char
                break
            }
        }
        if {!$found} {
            append res "#"
        }
        unset counts
        lshift S
    }
    puts [string reverse $res]
}

task2 ababc
task2 xyzzyx
