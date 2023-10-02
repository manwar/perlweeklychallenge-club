#!/usr/bin/env tclsh
set comment {
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08--15
Challenge 230 Count Words Task 2 ( Tcl )
--------------------------------------
}

set wds  {{pay attention practice attend} {janet julia java javascript}}
set prefix {at ja}

set cnt 0

foreach w $wds {
    set seen 0
    puts "Input: @words = ($w)"
    set p [lindex $prefix $cnt]
    set p "^${p}"
    puts "\tprefix = $p"
    foreach elem $w {
        if {[regexp $p $elem]} {
            expr [incr seen]
        }
    }
    puts "\tOutput: $seen\n"
    expr [ incr cnt]
}

set comment {
--------------------------------------
SAMPLE OUTPUT
tclsh .\CountWords.tcl

Input: @words = (pay attention practice attend)
        prefix = ^at
        Output: 2

Input: @words = (janet julia java javascript)
        prefix = ^ja
        Output: 3
--------------------------------------
}



