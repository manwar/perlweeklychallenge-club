#!/usr/bin/env tclsh
#
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers.
# 
# Write a script to return true if the given array can be divided into one or
# more groups: each group must be of the same size as the others, with at least
# two members, and with all members having the same value.
# 
# Example 1
# 
#     Input: @ints = (1,1,2,2,2,2)
#     Output: true
# 
#     Groups: (1,1), (2,2), (2,2)
# 
# Example 2
# 
#     Input: @ints = (1,1,1,2,2,2,3,3)
#     Output: false
# 
#     Groups: (1,1,1), (2,2,2), (3,3)
# 
# Example 3
# 
#     Input: @ints = (5,5,5,5,5,5,7,7,7,7,7,7)
#     Output: true
# 
#     Groups: (5,5,5,5,5,5), (7,7,7,7,7,7)
# 
# Example 4
# 
#     Input: @ints = (1,2,3,4)
#     Output: false
# 
# Example 5
# 
#     Input: @ints = (8,8,9,9,10,10,11,11)
#     Output: true
# 
#     Groups: (8,8), (9,9), (10,10), (11,11)
# 

package require tcltest

set cases {
    {{1 1 2 2 2 2}             1 "Example 1"} 
    {{1 1 1 2 2 2 3 3}         0 "Example 2"} 
    {{5 5 5 5 5 5 7 7 7 7 7 7} 1 "Example 3"} 
    {{1 2 3 4}                 0 "Example 4"} 
    {{8 8 9 9 10 10 11 11}     1 "Example 5"} 
}

proc equal_group {ints} {
    array set count {}
    foreach i $ints {
        incr count($i)
    }
    foreach key [lsort -integer [array names count]] {
        lappend values $count($key)
    }
    set min [lindex $values 0]
    foreach v [lrange $values 1 end] {
        if {$v < $min} {
            set min $v
        }
    }
    if {$min < 2} {
        return 0
    }
    for {set size 2} {$size <= $min} {incr size} {
        set ok 1
        foreach v [lrange $values 1 end] {
            if {$v % $size != 0} {
                set ok 0
                break
            }
        }
        if {$ok} {
            return 1
        }
    }
    return 0
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        equal_group [lindex $case 0]
    } [lindex $case 1]
}

exit 0

