#!/usr/bin/env tclsh
#
# Task 2: Odd Matrix
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given row and col, also a list of positions in the matrix.
# 
# Write a script to perform action on each location (0-indexed) as provided in
# the list and find out the total odd valued cells.
# 
# For each location (r, c), do both of the following:
# 
#     a) Increment by 1 all the cells on row r.
#     b) Increment by 1 all the cells on column c.
# 
# Example 1
# 
#     Input: $row = 2, $col = 3, @locations = ([0,1],[1,1])
#     Output: 6
# 
#     Initial:
#     [ 0 0 0 ]
#     [ 0 0 0 ]
# 
#     Apply [0,1]:
#     Increment row 0:
#     Before     After
#     [ 0 0 0 ]  [ 1 1 1 ]
#     [ 0 0 0 ]  [ 0 0 0 ]
#     Increment col 1:
#     Before     After
#     [ 1 1 1 ]  [ 1 2 1 ]
#     [ 0 0 0 ]  [ 0 1 0 ]
# 
#     Apply [1,1]:
#     Increment row 1:
#     Before     After
#     [ 1 2 1 ]  [ 1 2 1 ]
#     [ 0 1 0 ]  [ 1 2 1 ]
#     Increment col 1:
#     Before     After
#     [ 1 2 1 ]  [ 1 3 1 ]
#     [ 1 2 1 ]  [ 1 3 1 ]
# 
#     Final:
#     [ 1 3 1 ]
#     [ 1 3 1 ]
# 
# Example 2
# 
#     Input: $row = 2, $col = 2, @locations = ([1,1],[0,0])
#     Output: 0
# 
#     Initial:
#     [ 0 0 ]
#     [ 0 0 ]
# 
#     Apply [1,1]:
#     Increment row 1:
#     Before    After
#     [ 0 0 ]   [ 0 0 ]
#     [ 0 0 ]   [ 1 1 ]
#     Increment col 1:
#     Before    After
#     [ 0 0 ]   [ 0 1 ]
#     [ 1 1 ]   [ 1 2 ]
# 
#     Apply [0,0]:
#     Increment row 0:
#     Before    After
#     [ 0 1 ]   [ 1 2 ]
#     [ 1 2 ]   [ 1 2 ]
#     Increment col 0:
#     Before    After
#     [ 1 2 ]   [ 2 2 ]
#     [ 1 2 ]   [ 2 2 ]
# 
#     Final:
#     [ 2 2 ]
#     [ 2 2 ]
# 
# Example 3
# 
#     Input: $row = 3, $col = 3, @locations = ([0,0],[1,2],[2,1])
#     Output: 0
# 
#     Initial:
#     [ 0 0 0 ]
#     [ 0 0 0 ]
#     [ 0 0 0 ]
# 
#     Apply [0,0]:
#     Increment row 0:
#     Before     After
#     [ 0 0 0 ]  [ 1 1 1 ]
#     [ 0 0 0 ]  [ 0 0 0 ]
#     [ 0 0 0 ]  [ 0 0 0 ]
#     Increment col 0:
#     Before     After
#     [ 1 1 1 ]  [ 2 1 1 ]
#     [ 0 0 0 ]  [ 1 0 0 ]
#     [ 0 0 0 ]  [ 1 0 0 ]
# 
#     Apply [1,2]:
#     Increment row 1:
#     Before     After
#     [ 2 1 1 ]  [ 2 1 1 ]
#     [ 1 0 0 ]  [ 2 1 1 ]
#     [ 1 0 0 ]  [ 1 0 0 ]
#     Increment col 2:
#     Before     After
#     [ 2 1 1 ]  [ 2 1 2 ]
#     [ 2 1 1 ]  [ 2 1 2 ]
#     [ 1 0 0 ]  [ 1 0 1 ]
# 
#     Apply [2,1]:
#     Increment row 2:
#     Before     After
#     [ 2 1 2 ]  [ 2 1 2 ]
#     [ 2 1 2 ]  [ 2 1 2 ]
#     [ 1 0 1 ]  [ 2 1 2 ]
#     Increment col 1:
#     Before     After
#     [ 2 1 2 ]  [ 2 2 2 ]
#     [ 2 1 2 ]  [ 2 2 2 ]
#     [ 2 1 2 ]  [ 2 2 2 ]
# 
#     Final:
#     [ 2 2 2 ]
#     [ 2 2 2 ]
#     [ 2 2 2 ]
# 
# Example 4
# 
#     Input: $row = 1, $col = 5, @locations = ([0,2],[0,4])
#     Output: 2
# 
#     Initial:
#     [ 0 0 0 0 0 ]
# 
#     Apply [0,2]:
#     Increment row 0:
#     Before         After
#     [ 0 0 0 0 0 ]  [ 1 1 1 1 1 ]
#     Increment col 2:
#     Before         After
#     [ 1 1 1 1 1 ]  [ 1 1 2 1 1 ]
# 
#     Apply [0,4]:
#     Increment row 0:
#     Before         After
#     [ 1 1 2 1 1 ]  [ 2 2 3 2 2 ]
#     Increment col 4:
#     Before         After
#     [ 2 2 3 2 2 ]  [ 2 2 3 2 3 ]
# 
#     Final:
#     [ 2 2 3 2 3 ]
# 
# Example 5
# 
#     Input: $row = 4, $col = 2, @locations = ([1,0],[3,1],[2,0],[0,1])
#     Output: 8
# 
#     Initial:
#     [ 0 0 ]
#     [ 0 0 ]
#     [ 0 0 ]
#     [ 0 0 ]
# 
#     Apply [1,0]:
#     Increment row 1:
#     Before     After
#     [ 0 0 ]    [ 0 0 ]
#     [ 0 0 ]    [ 1 1 ]
#     [ 0 0 ]    [ 0 0 ]
#     [ 0 0 ]    [ 0 0 ]
#     Increment col 0:
#     Before     After
#     [ 0 0 ]    [ 1 0 ]
#     [ 1 1 ]    [ 2 1 ]
#     [ 0 0 ]    [ 1 0 ]
#     [ 0 0 ]    [ 1 0 ]
# 
#     Apply [3,1]:
#     Increment row 3:
#     Before     After
#     [ 1 0 ]    [ 1 0 ]
#     [ 2 1 ]    [ 2 1 ]
#     [ 1 0 ]    [ 1 0 ]
#     [ 1 0 ]    [ 2 1 ]
#     Increment col 1:
#     Before     After
#     [ 1 0 ]    [ 1 1 ]
#     [ 2 1 ]    [ 2 2 ]
#     [ 1 0 ]    [ 1 1 ]
#     [ 2 1 ]    [ 2 2 ]
# 
#     Apply [2,0]:
#     Increment row 2:
#     Before     After
#     [ 1 1 ]    [ 1 1 ]
#     [ 2 2 ]    [ 2 2 ]
#     [ 1 1 ]    [ 2 2 ]
#     [ 2 2 ]    [ 2 2 ]
#     Increment col 0:
#     Before     After
#     [ 1 1 ]    [ 2 1 ]
#     [ 2 2 ]    [ 3 2 ]
#     [ 2 2 ]    [ 3 2 ]
#     [ 2 2 ]    [ 3 2 ]
# 
#     Apply [0,1]:
#     Increment row 0:
#     Before     After
#     [ 2 1 ]    [ 3 2 ]
#     [ 3 2 ]    [ 3 2 ]
#     [ 3 2 ]    [ 3 2 ]
#     [ 3 2 ]    [ 3 2 ]
#     Increment col 1:
#     Before     After
#     [ 3 2 ]    [ 3 3 ]
#     [ 3 2 ]    [ 3 3 ]
#     [ 3 2 ]    [ 3 3 ]
#     [ 3 2 ]    [ 3 3 ]
# 
#     Final:
#     [ 3 3 ]
#     [ 3 3 ]
#     [ 3 3 ]
#     [ 3 3 ]
# 

package require tcltest

set cases {
    {{2 3 {{0 1} {1 1}}}             6 "Example 1"}
    {{2 2 {{1 1} {0 0}}}             0 "Example 2"}
    {{3 3 {{0 0} {1 2} {2 1}}}       0 "Example 3"}
    {{1 5 {{0 2} {0 4}}}             2 "Example 4"}
    {{4 2 {{1 0} {3 1} {2 0} {0 1}}} 8 "Example 5"}
}

proc odd_matrix {p} {
    set r   [lindex $p 0]
    set c   [lindex $p 1]
    set loc [lindex $p 2]
    set matrix {}
    for {set i 0} {$i < $r} {incr i} {
        lappend matrix [list]
        for {set j 0} {$j < $c} {incr j} {
            lset matrix $i $j 0
        }
    }
    foreach l $loc {
        set rr [lindex $l 0]
        set cc [lindex $l 1]
        for {set i 0} {$i < $c} {incr i} {
            lset matrix $rr $i [expr [lindex [lindex $matrix $rr] $i] + 1]
        }
        for {set i 0} {$i < $r} {incr i} {
            lset matrix $i $cc [expr [lindex [lindex $matrix $i] $cc] + 1]
        }
    }
    set odd_count 0
    for {set i 0} {$i < $r} {incr i} {
        for {set j 0} {$j < $c} {incr j} {
            if {[expr [lindex [lindex $matrix $i] $j] % 2]} {
                incr odd_count
            }
        }
    }
    return $odd_count
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        odd_matrix [lindex $case 0]
    } [lindex $case 1]
}

exit 0

