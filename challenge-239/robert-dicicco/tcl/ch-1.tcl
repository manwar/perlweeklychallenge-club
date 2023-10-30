#!/usr/bin/env tclsh
# -------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-10-16
# Challenge 239 Task 01 Same String ( Tcl )
# ------------------------------------

set myarr1 {{"ab" "c"} {"ab" "c"} {"ab" "cd" "e"}}
set myarr2 {{"a" "bc"} {"ac" "b"} {"abcde"}}
set cnt 0
while { $cnt < [llength $myarr1]} {
    puts "Input:  @arr1 = [lindex $myarr1 $cnt]"
    puts "\t@arr2 = [lindex $myarr2 $cnt]"
    set str1 ""
    set str2 ""
    foreach wd1 [lindex $myarr1 $cnt] {
        append str1 $wd1
     }
     foreach wd2 [lindex $myarr2 $cnt] {
        append str2 $wd2
    }
    if { $str1 == $str2 } {
        puts "Output: true\n"
    } else {
        puts "Output: false\n"
    }

    incr cnt
}

# -------------------------------------
# SAMPLE OUTPUT

# tclsh .\SameString.tcl

# Input:  @arr1 = "ab" "c"
#         @arr2 = "a" "bc"
# Output: true

# Input:  @arr1 = "ab" "c"
#         @arr2 = "ac" "b"
# Output: false

# Input:  @arr1 = "ab" "cd" "e"
#         @arr2 = "abcde"
# Output: true
# ------------------------------------


