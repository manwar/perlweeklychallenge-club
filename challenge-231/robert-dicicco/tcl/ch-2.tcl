#!/usr/bin/env tclsh

set header {
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-21
Challenge 231 Senior Citizen Task 2 ( Tcl )
----------------------------------------
}

set lists {{7868190130M7522 5303914400F9211 9273338290F4010} {1313579440F2036 2921522980M5644}}

foreach lst $lists {
    set cnt 0
    puts "Input: @list = ($lst)"
    foreach info $lst {
        set sage [string range $info 11 12]
        set age [expr $sage]
        if {$age >= 60 } {
            set cnt [expr $cnt + 1]
        }
    }
    puts "Output: $cnt\n"
}

set sample {
tclsh .\SeniorCit.tcl

Input: @list = (7868190130M7522 5303914400F9211 9273338290F4010)
Output: 2

Input: @list = (1313579440F2036 2921522980M5644)
Output: 0
}



