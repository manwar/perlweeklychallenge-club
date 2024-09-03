#!/usr/bin/env tclsh
#
# Task 2: Making Change
# 
# Submitted by: David Ferrone
# 
# Compute the number of ways to make change for given amount in cents. By using
# the coins e.g. Penny, Nickel, Dime, Quarter and Half-dollar, in how many
# distinct ways can the total value equal to the given amount? Order of coin
# selection does not matter.
# 
#     A penny (P) is equal to 1 cent.
#     A nickel (N) is equal to 5 cents.
#     A dime (D) is equal to 10 cents.
#     A quarter (Q) is equal to 25 cents.
#     A half-dollar (HD) is equal to 50 cents.
# 
# Example 1
# 
#     Input: $amount = 9
#     Ouput: 2
# 
#     1: 9P
#     2: N + 4P
# 
# Example 2
# 
#     Input: $amount = 15
#     Ouput: 6
# 
#     1: D + 5P
#     2: D + N
#     3: 3N
#     4: 2N + 5P
#     5: N + 10P
#     6: 15P
# 
# Example 3
# 
#     Input: $amount = 100
#     Ouput: 292
# 

package require tcltest

set cases {
    {  9   2 "Example 1"}
    { 15   6 "Example 2"}
    {100 292 "Example 3"}
}

# https://tech.tonyballantyne.com/2019/03/04/coin-change-problem/
#             HD   Q   D  N  P
set values [list 50 25 10 5 1]

proc coin {n val} {
    global values

    if {[lindex $values $val] == 1} {
        return 1
    }

    set total 0
    while {$n >= [lindex $values $val]} {
        incr total [coin $n [expr $val + 1]]
        incr n [expr - [lindex $values $val]]
    }
    incr total [coin $n [expr $val + 1]]
    return $total
}

proc making_change {sum} {
    return [coin $sum 0]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        making_change [lindex $case 0]
    } [lindex $case 1]
}

exit 0
