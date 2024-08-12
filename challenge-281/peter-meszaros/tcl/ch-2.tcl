#!/usr/bin/env tclsh
#
# Task 2: Knight's Move
#
# Submitted by: Peter Campbell Smith
#
# A Knight in chess can move from its current position to any square two rows or
# columns plus one column or row away. So in the diagram below, if it starts a S,
# it can move to any of the squares marked E.
#
# Write a script which takes a starting position and an ending position and
# calculates the least number of moves required.
#
#       +--+--+--+--+--+--+--+--+
#     8 |a8|  |  |  |  |  |  |  |
#     7 |  |  |E |  |E |  |  |  |
#     6 |  |E |  |  |  |E |  |  |
#     5 |  |  |  |S |  |  |  |  |
#    4 |  |E |  |  |  |E |  |  |
#    3 |  |  |E |  |E |  |  |  |
#    2 |  |  |  |  |  |  |g2|  |
#    1 |  |  |  |  |  |  |  |  |
#      +--+--+--+--+--+--+--+--+
#        a  b  c  d  e  f  g  h
#
# Example 1
#
#    Input: $start = 'g2', $end = 'a8'
#    Ouput: 4
#
#    g2 -> e3 -> d5 -> c7 -> a8
#
# Example 2
#
#    Input: $start = 'g2', $end = 'h2'
#    Ouput: 3
#
#    g2 -> e3 -> f1 -> h2
#

package require tcltest
package require struct::queue
package require struct::matrix

set cases {
    {{g2 a8} 4 "Example 1"}
    {{g2 h2} 3 "Example 2"}
}

proc knights_move {params} {

    set s [split [lindex $params 0] {}]
    set e [split [lindex $params 1] {}]
    set sx [expr [scan [lindex $s 0] %c] - [scan "a" %c]]
    set ex [expr [scan [lindex $e 0] %c] - [scan "a" %c]]
    set sy [expr [lindex $s 1] - 1]
    set ey [expr [lindex $e 1] - 1]
    set dx {2  2 -2 -2 1  1 -1 -1}
    set dy {1 -1  1 -1 2 -2  2 -2}

    set queue [::struct::queue]
    $queue put [list $sx $sy 0]

    set visited [::struct::matrix]
    $visited add rows 8
    $visited add columns 8

    while {[$queue size]} {
        set p [$queue get]
        set x [lindex $p 0]
        set y [lindex $p 1]
        set v [lindex $p 2]
        if {$x == $ex && $y == $ey} {
            $queue destroy
            $visited destroy
            return $v
        }
        for {set i 0} {$i < 8} {incr i} {
            set new_x [expr $x + [lindex $dx $i]]
            set new_y [expr $y + [lindex $dy $i]]
            set val [expr $v + 1]
            if {$new_x >= 0 && $new_x <= 7 &&
                $new_y >= 0 && $new_y <= 7 &&
                [$visited get cell $new_x $new_y] != 1} {
                $visited set cell $new_x $new_y 1
                $queue put [list $new_x $new_y $val]
             }
        }
    }
    $queue destroy
    $visited destroy
    return null
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        knights_move [lindex $case 0]
    } [lindex $case 1]
}

exit 0
