#!/usr/bin/env tclsh
#
# Task 2: Array Formation
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two list: @source and @target.
# 
# Write a script to see if you can build the exact @target by putting these
# smaller lists from @source together in some order. You cannot break apart or
# change the order inside any of the smaller lists in @source.
# 
# Example 1
# 
#     Input: @source = ([2,3], [1], [4])
#            @target = (1, 2, 3, 4)
#     Output: true
# 
#     Use in the order: [1], [2,3], [4]
# 
# Example 2
# 
#     Input: @source = ([1,3], [2,4])
#            @target = (1, 2, 3, 4)
#     Output: false
# 
# Example 3
# 
#     Input: @source = ([9,1], [5,8], [2])
#            @target = (5, 8, 2, 9, 1)
#     Output: true
# 
#     Use in the order: [5,8], [2], [9,1]
# 
# Example 4
# 
#     Input: @source = ([1], [3])
#            @target = (1, 2, 3)
#     Output: false
# 
#     Missing number: 2
# 
# Example 5
# 
#     Input: @source = ([7,4,6])
#            @target = (7, 4, 6)
#     Output: true
# 
#     Use in the order: [7, 4, 6]
# 

package require tcltest

set cases {
    {{{{2 3} {1} {4}}   {1 2 3 4}}   true  "Example 1"}
    {{{{1 3} {2 4}}     {1 2 3 4}}   false "Example 2"}
    {{{{9 1} {5 8} {2}} {5 8 2 9 1}} true  "Example 3"}
    {{{{1} {3}}         {1 2 3}}     false "Example 4"}
    {{{{7 4 6}}         {7 4 6}}     true  "Example 5"}
}

proc array_formation {p} {
    set source [lindex $p 0]
    set target [lindex $p 1]

    proc _equal_arrays {source target} {
        if {[llength $source] != [llength $target]} {
            return false
        }
        for {set i 0} {$i < [llength $source]} {incr i} {
            if {[lindex $source $i] != [lindex $target $i]} {
                return false
            }
        }
        return true
    }

    foreach subarray $source {
        set len [llength $subarray]
        set found 0
        for {set j 0} {$j <= [expr [llength $target] - $len]} {incr j} {
            set target_slice [lrange $target $j [expr $j + $len - 1]]
            if {[_equal_arrays $subarray $target_slice]} {
                set target [concat [lrange $target 0 [expr $j - 1]] \
                                    [lrange $target [expr $j + $len] end]]
                set found 1
                break
            }
        }
        if {!$found} {
            return false
        }
    }
    return [expr [llength $target] == 0 ? true : false]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        array_formation [lindex $case 0]
    } [lindex $case 1]
}

exit 0

