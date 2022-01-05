#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-002
#

#
# Run as: tclsh ch-2.tcl < input-file
#

set frombase  0
set   tobase  0
set glyphs   "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
set     base 35

if {$argc == 1} {
    if {[lindex $argv 0] == "-f"} {
        set frombase 1
    }
    if {[lindex $argv 0] == "-t"} {
        set   tobase 1
    }
}

proc from_base {num base} {
    global glyphs
    set out 0
    foreach c [split $num {}] {
        set out [expr $base * $out + [string first $c $glyphs]]
    }
    return $out
}

proc to_base {num base} {
    global glyphs
    if {$num == 0} {
        return 0
    }
    set out ""
    while {$num > 0} {
        set out [string index $glyphs [expr {$num % $base}]]$out
        set num [expr $num / $base]
    }
    return $out
}



while {[gets stdin line] >= 0} {
    if {$frombase == 1} {
        puts [from_base $line $base]
    }
    if {  $tobase == 1} {
        puts [  to_base $line $base]
    }
}
