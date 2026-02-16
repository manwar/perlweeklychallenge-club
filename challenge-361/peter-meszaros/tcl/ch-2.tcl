#!/usr/bin/env tclsh
#
# Task 2: Find Celebrity
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a binary matrix (m x n).  Write a script to find the celebrity,
# return -1 when none found.  A celebrity is someone, everyone knows and knows
# nobody.
# 
# Example 1
# 
#     Input: @party = (
#                 [0, 0, 0, 0, 1, 0],  # 0 knows 4
#                 [0, 0, 0, 0, 1, 0],  # 1 knows 4
#                 [0, 0, 0, 0, 1, 0],  # 2 knows 4
#                 [0, 0, 0, 0, 1, 0],  # 3 knows 4
#                 [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
#                 [0, 0, 0, 0, 1, 0],  # 5 knows 4
#            );
#     Output: 4
# 
# Example 2
# 
#     Input: @party = (
#                 [0, 1, 0, 0],  # 0 knows 1
#                 [0, 0, 1, 0],  # 1 knows 2
#                 [0, 0, 0, 1],  # 2 knows 3
#                 [1, 0, 0, 0]   # 3 knows 0
#            );
#     Output: -1
# 
# Example 3
# 
#     Input: @party = (
#                 [0, 0, 0, 0, 0],  # 0 knows NOBODY
#                 [1, 0, 0, 0, 0],  # 1 knows 0
#                 [1, 0, 0, 0, 0],  # 2 knows 0
#                 [1, 0, 0, 0, 0],  # 3 knows 0
#                 [1, 0, 0, 0, 0]   # 4 knows 0
#            );
#     Output: 0
# 
# Example 4
# 
#     Input: @party = (
#                 [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
#                 [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
#                 [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
#                 [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
#                 [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
#                 [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
#            );
#     Output: 3
# 
# Example 5
# 
#     Input: @party = (
#                 [0, 1, 1, 0],  # 0 knows 1 and 2
#                 [1, 0, 1, 0],  # 1 knows 0 and 2
#                 [0, 0, 0, 0],  # 2 knows NOBODY
#                 [0, 0, 0, 0]   # 3 knows NOBODY
#            );
#     Output: -1
# 
# Example 6
# 
#     Input: @party = (
#                 [0, 0, 1, 1],  # 0 knows 2 and 3
#                 [1, 0, 0, 0],  # 1 knows 0
#                 [1, 1, 0, 1],  # 2 knows 0, 1 and 3
#                 [1, 1, 0, 0]   # 3 knows 0 and 1
#           );
#     Output: -1
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{{0 0 0 0 1 0}
      {0 0 0 0 1 0}
      {0 0 0 0 1 0}
      {0 0 0 0 1 0}
      {0 0 0 0 0 0}
      {0 0 0 0 1 0}
        } 4 "Example 1"}
    {{{0 1 0 0}
      {0 0 1 0}
      {0 0 0 1}
      {1 0 0 0} 
        } -1 "Example 2"}
    {{{0 0 0 0 0}
      {1 0 0 0 0}
      {1 0 0 0 0}
      {1 0 0 0 0}
      {1 0 0 0 0} 
        } 0 "Example 3"}
    {{{0 1 0 1 0 1}
      {1 0 1 1 0 0}
      {0 0 0 1 1 0}
      {0 0 0 0 0 0}
      {0 1 0 1 0 0}
      {1 0 1 1 0 0} 
        } 3 "Example 4"}
    {{{0 1 1 0}
      {1 0 1 0}
      {0 0 0 0}
      {0 0 0 0} 
        } -1 "Example 5"}
    {{{0 0 1 1}
      {1 0 0 0}
      {1 1 0 1}
      {1 1 0 0} 
        } -1 "Example 6"}
}

proc find_celebrity {party} {
    set n [llength $party]
    for {set i 0} {$i < $n} {incr i} {
        set knows_nobody true
        for {set j 0} {$j < $n} {incr j} {
            if {[lindex [lindex $party $i] $j]} {
                set knows_nobody false
                break
            }
        }
        if {$knows_nobody} {
            set known_by_everybody true
            for {set k 0} {$k < $n} {incr k} {
                if {$k != $i && ![lindex [lindex $party $k] $i]} {
                    set known_by_everybody false
                    break
                }
            }
            if {$known_by_everybody} {
                return $i
            }
        }
    }
    return -1
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        find_celebrity [lindex $case 0]
    } [lindex $case 1]
}

exit 0

