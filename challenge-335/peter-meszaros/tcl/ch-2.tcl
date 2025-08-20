#!/usr/bin/env tclsh
#
# Task 2: Find Winner
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of all moves by the two players.
# 
# Write a script to find the winner of the TicTacToe game if found based on the
# moves provided in the given array.
# 
# UPDATE: Order move is in the order - A, B, A, B, A, ...
# 
# Example 1
# 
#     Input: @moves = ([0,0],[2,0],[1,1],[2,1],[2,2])
#     Output: A
# 
#     Game Board:
#     [ A _ _ ]
#     [ B A B ]
#     [ _ _ A ]
# 
# Example 2
# 
#     Input: @moves = ([0,0],[1,1],[0,1],[0,2],[1,0],[2,0])
#     Output: B
# 
#     Game Board:
#     [ A A B ]
#     [ A B _ ]
#     [ B _ _ ]
# 
# Example 3
# 
#     Input: @moves = ([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2])
#     Output: Draw
# 
#     Game Board:
#     [ A A B ]
#     [ B B A ]
#     [ A B A ]
# 
# Example 4
# 
#     Input: @moves = ([0,0],[1,1])
#     Output: Pending
# 
#     Game Board:
#     [ A _ _ ]
#     [ _ B _ ]
#     [ _ _ _ ]
# 
# Example 5
# 
#     Input: @moves = ([1,1],[0,0],[2,2],[0,1],[1,0],[0,2])
#     Output: B
# 
#     Game Board:
#     [ B B B ]
#     [ A A _ ]
#     [ _ _ A ]
# 

package require tcltest

set cases {
    {{{0 0} {2 0} {1 1} {2 1} {2 2}}                          "A"        "Example 1"} 
    {{{0 0} {1 1} {0 1} {0 2} {1 0} {2 0}}                    "B"        "Example 2"} 
    {{{0 0} {1 1} {2 0} {1 0} {1 2} {2 1} {0 1} {0 2} {2 2}}  "Draw"     "Example 3"} 
    {{{0 0} {1 1}}                                            "Pending"  "Example 4"} 
    {{{1 1} {0 0} {2 2} {0 1} {1 0} {0 2}}                    "B"        "Example 5"} 
}

proc check_winner {board player} {
    for {set i 0} {$i < 3} {incr i} {
        if {[lindex $board $i 0] eq $player && \
            [lindex $board $i 1] eq $player && \
            [lindex $board $i 2] eq $player} {
            return 1
        }
        if {[lindex $board 0 $i] eq $player && \
            [lindex $board 1 $i] eq $player && \
            [lindex $board 2 $i] eq $player} {
            return 1
        }
    }

    if {[lindex $board 0 0] eq $player && \
        [lindex $board 1 1] eq $player && \
        [lindex $board 2 2] eq $player} {
        return 1
    }
    if {[lindex $board 0 2] eq $player && \
        [lindex $board 1 1] eq $player && \
        [lindex $board 2 0] eq $player} {
        return 1
    }
    return 0
}

proc find_winner {moves} {
    set board {{_ _ _} {_ _ _} {_ _ _}}
    set turn 0

    foreach move $moves {
        set x [lindex $move 0]
        set y [lindex $move 1]
        set player [expr {$turn ? "B" : "A"}]
        lset board $x $y $player

        if {[check_winner $board $player]} {
            return $player
        }

        set turn [expr 1 - $turn]
    }

    return [expr {[llength $moves] < 9 ? "Pending" : "Draw"}]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        find_winner [lindex $case 0]
    } [lindex $case 1]
}

exit 0

