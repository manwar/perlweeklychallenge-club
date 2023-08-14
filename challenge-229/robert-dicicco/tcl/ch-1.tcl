#!/usr/bin/env tclsh
set comment {
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-07
Challenge 229 Lexical Order Task 1 ( Tcl )
---------------------------------------
}

set strs {{abc bce cae} {yxz cba mon}}

set cnt 0

proc CheckLexOrder {e}  {
    set sortedString [join [lsort [split $e ""]] ""]
    if {$e eq $sortedString} {
        return 1
    } elseif {$e eq [string reverse $sortedString]} {
        return 1
    } else {
        return 0
    }
}

foreach str $strs {
    puts "Input: @str = ($str)"
    foreach elm $str {
        set retval [CheckLexOrder $elm]
        if {$retval == 0} {
            incr cnt
        }
    }
    puts "Output: $cnt\n"
    set cnt 0
}

set comment {
---------------------------------------
SAMPLE OUTPUT
tclsh .\LexOrder.tcl

Input: @str = (abc bce cae)
Output: 1

Input: @str = (yxz cba mon)
Output: 2
---------------------------------------
}


