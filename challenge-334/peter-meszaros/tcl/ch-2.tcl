#!/usr/bin/env tclsh
#
# Task 2: Nearest Valid Point
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given current location as two integers: x and y. You are also given a
# list of points on the grid.
# 
# A point is considered valid if it shares either the same x-coordinate or the
# same y-coordinate as the current location.
# 
# Write a script to return the index of the valid point that has the smallest
# Manhattan distance to the current location. If multiple valid points are tied
# for the smallest distance, return the one with the lowest index. If no valid
# points exist, return -1.
# 
# The Manhattan distance between two points (x1, y1) and (x2, y2) is calculated
# as: |x1 - x2| + |y1 - y2|
# 
# Example 1
# 
#     Input: $x = 3, $y = 4, @points ([1, 2], [3, 1], [2, 4], [2, 3])
#     Output: 2
# 
#     Valid points: [3, 1] (same x), [2, 4] (same y)
# 
#     Manhattan distances:
#         [3, 1] => |3-3| + |4-1| = 3
#         [2, 4] => |3-2| + |4-4| = 1
# 
#     Closest valid point is [2, 4] at index 2.
# 
# Example 2
# 
#     Input: $x = 2, $y = 5, @points ([3, 4], [2, 3], [1, 5], [2, 5])
#     Output: 3
# 
#     Valid points: [2, 3], [1, 5], [2, 5]
# 
#     Manhattan distances:
#         [2, 3] => 2
#         [1, 5] => 1
#         [2, 5] => 0
# 
#     Closest valid point is [2, 5] at index 3.
# 
# Example 3
# 
#     Input: $x = 1, $y = 1, @points ([2, 2], [3, 3], [4, 4])
#     Output: -1
# 
#     No point shares x or y with (1, 1).
# 
# Example 4
# 
#     Input: $x = 0, $y = 0, @points ([0, 1], [1, 0], [0, 2], [2, 0])
#     Output: 0
# 
#     Valid points: all of them
# 
#     Manhattan distances:
#         [0, 1] => 1
#         [1, 0] => 1
#         [0, 2] => 2
#         [2, 0] => 2
# 
#     Tie between index 0 and 1, pick the smaller index: 0
# 
# Example 5
# 
#     Input: $x = 5, $y = 5, @points ([5, 6], [6, 5], [5, 4], [4, 5])
#     Output: 0
# 
#     Valid points: all of them
#         [5, 6] => 1
#         [6, 5] => 1
#         [5, 4] => 1
#         [4, 5] => 1
# 
#     All tie, return the one with the lowest index: 0
# 

package require tcltest

set cases {
    {{{3 4} {{1 2} {3 1} {2 4} {2 3}}}  2 "Example 1"}
    {{{2 5} {{3 4} {2 3} {1 5} {2 5}}}  3 "Example 2"}
    {{{1 1} {{2 2} {3 3} {4 4}}}       -1 "Example 3"}
    {{{0 0} {{0 1} {1 0} {0 2} {2 0}}}  0 "Example 4"}
    {{{5 5} {{5 6} {6 5} {5 4} {4 5}}}  0 "Example 5"}
}

proc nearest_valid_point {p} {
    set x [lindex [lindex $p 0] 0]
    set y [lindex [lindex $p 0] 1]
    set points [lindex $p 1]

    set idx -1
    set i -1
    set min_dist {}
    
    foreach point $points {
        incr i
        if {[lindex $point 0] == $x || [lindex $point 1] == $y} {
            set d [expr {abs($x - [lindex $point 0]) + abs($y - [lindex $point 1])}]
            if {$min_dist eq "" || $d < $min_dist} {
                set min_dist $d
                set idx $i
            }
        }
    }
    
    return $idx
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        nearest_valid_point [lindex $case 0]
    } [lindex $case 1]
}

exit 0

