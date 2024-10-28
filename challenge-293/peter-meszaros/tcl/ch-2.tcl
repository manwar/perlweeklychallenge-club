#!/usr/bin/env tclsh
#
# Task 2: Boomerang
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of points, (x, y).
# 
# Write a script to find out if the given points are a boomerang.
# 
#     A boomerang is a set of three points that are all distinct and not in a
#     straight line.
# 
# Example 1
# 
#     Input: @points = ( [1, 1], [2, 3], [3,2] )
#     Output: true
# 
# Example 2
# 
#     Input: @points = ( [1, 1], [2, 2], [3, 3] )
#     Output: false
# 
# Example 3
# 
#     Input: @points = ( [1, 1], [1, 2], [2, 3] )
#     Output: true
# 
# Example 4
# 
#     Input: @points = ( [1, 1], [1, 2], [1, 3] )
#     Output: false
# 
# Example 5
# 
#     Input: @points = ( [1, 1], [2, 1], [3, 1] )
#     Output: false
# 
# Example 6
# 
#     Input: @points = ( [0, 0], [2, 3], [4, 5] )
#     Output: true
# 

package require tcltest

set cases {
    {{{1 1} {2 3} {3 2}} true  "Example 1"}
    {{{1 1} {2 2} {3 3}} false "Example 2"}
    {{{1 1} {1 2} {2 3}} true  "Example 3"}
    {{{1 1} {1 2} {1 3}} false "Example 4"}
    {{{1 1} {2 1} {3 1}} false "Example 5"}
    {{{0 0} {2 3} {4 5}} true  "Example 6"}
}

proc boomerang {p} {
    # vertical line
    if {[lindex [lindex $p 0] 0] == [lindex [lindex $p 1] 0]} {
        return [expr [lindex [lindex $p 2] 0] != [lindex [lindex $p 0] 0] ? true : false]
    }
    # y = m * x + b
    set div [expr [lindex [lindex $p 1] 0] - [lindex [lindex $p 0] 0]]
    if {$div == 0} {
        set m $div
    } else {
        set m [expr ([lindex [lindex $p 1] 1] - [lindex [lindex $p 0] 1]) / $div]
    }
    set b [expr [lindex [lindex $p 0] 1] - $m * [lindex [lindex $p 0] 0]]
    return [expr [expr $m * [lindex [lindex $p 2] 0] + $b] != [lindex [lindex $p 2] 1] ? true : false]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       boomerang [lindex $case 0]
    } [lindex $case 1]
}

exit 0

sub boomerang
{
    my $p = shift;

    if ($p->[0]->[0] == $p->[1]->[0]) { # vertical line
        return ($p->[2]->[0] != $p->[0]->[0]) ? 1 : 0;
    }
    # y = m * x + b
    my $div = $p->[1]->[0] - $p->[0]->[0];
    my $m = ($div == 0) ? $div : ($p->[1]->[1] - $p->[0]->[1]) / $div;
    my $b = $p->[0]->[1] - $m * $p->[0]->[0];

    return ($m * $p->[2]->[0] + $b) != $p->[2]->[1] ? 1 : 0;
}

