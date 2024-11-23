#!/usr/bin/env tclsh
#
# Task 2: Matchstick Square
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# 
# Write a script to find if it is possible to make one square using the sticks as
# in the given array @ints where $ints[i] is the length of ith stick.
# 
# Example 1
# 
#     Input: @ints = (1, 2, 2, 2, 1)
#     Output: true
# 
#     Top: $ints[1] = 2
#     Bottom: $ints[2] = 2
#     Left: $ints[3] = 2
#     Right: $ints[0] and $ints[4] = 2
# 
# Example 2
# 
#     Input: @ints = (2, 2, 2, 4)
#     Output: false
# 
# Example 3
# 
#     Input: @ints = (2, 2, 2, 2, 4)
#     Output: false
# 
# Example 4
# 
#     Input: @ints = (3, 4, 1, 4, 3, 1)
#     Output: true
# 

package require tcltest

set cases {
    {{1 2 2 2 1}   1 "Example 1"}
    {{2 2 2 4}     0 "Example 2"}
    {{2 2 2 2 4}   0 "Example 3"}
    {{3 4 1 4 3 1} 1 "Example 4"}
}

proc ladd {l} {
    set total 0
    foreach nxt $l {
        incr total $nxt
    }
    return $total
}

proc matchstick_square {l} {
    set sum [ladd $l]
    if {[expr $sum % 4]} {
        return 0
    }
    global size square ls
    set size [expr $sum / 4]
    set ls [lsort -integer -decreasing $l]
    set square {0 0 0 0}

   proc dfs {start} {
       global size square ls
       if {$start == [llength $ls]} {
           return [expr $size == [lindex $square 0] && \
                        $size == [lindex $square 1] && \
                        $size == [lindex $square 2] && \
                        $size == [lindex $square 3]]
       }
 
       for {set i 0} {$i < 4} {incr i} {
            if {[expr [lindex $square $i] + [lindex $ls $start]] <= $size} {
                lset square $i [expr [lindex $square $i] + [lindex $ls $start]]
                if {[dfs [expr $start + 1]] == 1} {
                    return 1
                }
                lset square $i [expr [lindex $square $i] - [lindex $ls $start]]
            }
        }
        return 0
    }

    return [dfs 0]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        matchstick_square [lindex $case 0]
    } [lindex $case 1]
}

exit 0

