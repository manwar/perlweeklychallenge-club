#!/usr/bin/env tclsh
#
# Task 2: Word Search
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a grid of characters and a string.
# 
# Write a script to determine whether the given string can be found in the given
# grid of characters. You may start anywhere and take any orthogonal path, but
# may not reuse a grid cell.
# 
# Example 1
# 
#     Input: @chars = (['A', 'B', 'D', 'E'],
#                      ['C', 'B', 'C', 'A'],
#                      ['B', 'A', 'A', 'D'],
#                      ['D', 'B', 'B', 'C'])
#           $str = 'BDCA'
#     Output: true
# 
# Example 2
# 
#     Input: @chars = (['A', 'A', 'B', 'B'],
#                      ['C', 'C', 'B', 'A'],
#                      ['C', 'A', 'A', 'A'],
#                      ['B', 'B', 'B', 'B'])
#           $str = 'ABAC'
#     Output: false
# 
# Example 3
# 
#     Input: @chars = (['B', 'A', 'B', 'A'],
#                      ['C', 'C', 'C', 'C'],
#                      ['A', 'B', 'A', 'B'],
#                      ['B', 'B', 'A', 'A'])
#           $str = 'CCCAA'
#     Output: true
# 

package require tcltest

set cases {
    {{{{A B D E}
       {C B C A}
       {B A A D}
       {D B B C}} BDCA}  1 "Example 1"}
    {{{{A A B B}
       {C C B A}
       {C A A A}
       {B B B B}} ABAC}  0 "Example 2"}
    {{{{B A B A}
       {C C C C}
       {A B A B}
       {B B A A}} CCCAA} 1 "Example 3"}
    {{{{a x m y}
       {b g d f}
       {x e e t}
       {r a k s}} geeks} 1 "Example 4"}
}

proc find_match {mat word i j idx} {

    set l [string length $word]
    set n [llength $mat]
    set m [llength [lindex $mat 0]]

    if {$idx == $l} {
        return 1
    }

    if {$i < 0 || $j < 0 || $i >= $n || $j >= $m} {
        return 0
    }

    if {[lindex $mat $i $j] == [string index $word $idx]} {
 
        set temp [lindex $mat $i $j]
        lset mat $i $j "#"

        set res [expr [find_match $mat $word [expr $i-1]       $j    [expr $idx+1]] || \
                      [find_match $mat $word [expr $i+1]       $j    [expr $idx+1]] || \
                      [find_match $mat $word       $i    [expr $j-1] [expr $idx+1]] || \
                      [find_match $mat $word       $i    [expr $j+1] [expr $idx+1]]]

        lset mat $i $j $temp
        return $res
    }

    return 0
}

proc word_search {p} {
    set mat  [lindex $p 0]
    set word [lindex $p 1]

    set l [string length $word]
    set n [llength $mat]
    set m [llength [lindex $mat 0]]

    if {$l > [expr $n * $m]} {
        return 0
    }

    for {set i 0} {$i < $n} {incr i} {
        for {set j 0} {$j < $m} {incr j} {
            if {[lindex $mat $i $j] == [string index $word 0]} {
                if {[find_match $mat $word $i $j 0] == 1} {
                    return 1
                }
            }
        }
    }
    return 0
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       word_search [lindex $case 0]
    } [lindex $case 1]
}

exit 0

