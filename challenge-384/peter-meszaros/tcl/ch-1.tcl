#!/usr/bin/env tclsh
#
# Task 1: Base N
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a number and a base integer.  Write a script to convert the given
# number in the given base integer.
# 
# Example 1
# 
#     Input: $num = 42, $base = 2
#     Output: 101010
# 
# Example 2
# 
#     Input: $num = 15642094, $base = 16
#     Output: EEADEE
# 
# Example 3
# 
#     Input: $num = 493, $base = 8
#     Output: 755
# 
# Example 4
# 
#     Input: $num = 2228519, $base = 36
#     Output: 1BRJB
# 
#     Base 36 uses numbers 0-9 and letters A-Z.
# 
# Example 5
# 
#     Input: $num = 123456789, $base = 64
#     Output: 7MyqL
# 
#     Base 64 (using 0-9, A-Z, a-z, and extra symbols like + and /)
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{42          2} "101010" "Example 1"}
    {{15642094   16} "EEADEE" "Example 2"}
    {{493         8} "755"    "Example 3"}
    {{2228519    36} "1BRJB"  "Example 4"}
    {{123456789  64} "7MyqL"  "Example 5"}
}

proc base_n {p} {
    set num [lindex $p 0]
    set base [lindex $p 1]

    set out ""
    set digits {0 1 2 3 4 5 6 7 8 9
        A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
        a b c d e f g h i j k l m n o p q r s t u v w x y z
        + /}

    while {$num > 0} {
        set out [string cat [lindex $digits [expr $num % $base]] $out]
        set num [expr int($num / $base)]
    }
    return $out
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        base_n [lindex $case 0]
    } [lindex $case 1]
}

exit 0


