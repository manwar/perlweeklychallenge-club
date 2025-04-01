#!/usr/bin/env tclsh
#
# Task 1: Broken Keys
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You have a broken keyboard which sometimes type a character more than once.
# 
# You are given a string and actual typed string.
# 
# Write a script to find out if the actual typed string is meant for the given
# string.
# 
# Example 1
# 
#     Input: $name = "perl", $typed = "perrrl"
#     Output: true
# 
#     Here "r" is pressed 3 times instead of 1 time.
# 
# Example 2
# 
#     Input: $name = "raku", $typed = "rrakuuuu"
#     Output: true
# 
# Example 3
# 
#     Input: $name = "python", $typed = "perl"
#     Output: false
# 
# Example 4
# 
#     Input: $name = "coffeescript", $typed = "cofffeescccript"
#     Output: true
# 

package require tcltest

set cases {
    {{"perl"         "perrrl"}          1 "Example 1"}
    {{"raku"         "rrakuuuu"}        1 "Example 2"}
    {{"python"       "perl"}            0 "Example 3"}
    {{"coffeescript" "cofffeescccript"} 1 "Example 4"}
}

proc broken_keys {p} {
    set name [lindex $p 0]
    set typed [lindex $p 1]

    set name_idx 0
    set typed_idx 0
    set name_len [string length $name]
    set typed_len [string length $typed]

    for {set typed_idx 0} {$typed_idx < $typed_len} {incr typed_idx} {
        if {$name_idx >= $name_len || [string index $name $name_idx] ne [string index $typed $typed_idx]} {
            if {$typed_idx > 0 && [string index $typed $typed_idx] eq [string index $typed [expr $typed_idx - 1]]} {
                continue
            }
            return 0
        }
        incr name_idx
    }
    return 1
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       broken_keys [lindex $case 0]
    } [lindex $case 1]
}

exit 0

