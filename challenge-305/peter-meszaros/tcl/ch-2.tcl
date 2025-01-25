#!/usr/bin/env tclsh
#
# Task 2: Alien Dictionary
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of words and alien dictionary character order.
# 
# Write a script to sort lexicographically the given list of words based on the
# alien dictionary characters.
# 
# Example 1
# 
#     Input: @words = ("perl", "python", "raku")
#            @alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/
#     Output: ("raku", "python", "perl")
# 
# Example 2
# 
#     Input: @words = ("the", "weekly", "challenge")
#            @alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/
#     Output: ("challenge", "the", "weekly")
# 

package require tcltest

set cases {
    {{{perl python raku}
      {h l a b y d e f g i r k m n o p q j s t u v w x c z}}
     {raku python perl} "Example 1"}
    {{{the  weekly challenge}
      {c o r l d a b t e f g h i j k m n p q s w u v x y z}}
     {challenge the weekly} "Example 2"}
}

proc compare {a b} {
    global dd
    set i 0
    while { $i < [string length $a] && $i < [string length $b] } {
        set ai [dict get $dd [string index $a $i]]
        set bi [dict get $dd [string index $b $i]]
        if { $ai != $bi } {
            return [expr {$ai - $bi}]
        }
        incr i
    }
    return [expr {[string length $a] - [string length $b]}]
}

proc alien_dictionary {p} {
    set l [lindex $p 0]
    set d [lindex $p 1]

    set x 0
    global dd
    set dd {}
    foreach i $d {
        dict set dd $i $x
        incr x
    }

    set sl [lsort -command compare $l]

    return $sl
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       alien_dictionary [lindex $case 0]
    } [lindex $case 1]
}

exit 0

