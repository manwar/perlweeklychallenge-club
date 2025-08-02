#!/usr/bin/env tclsh
#
# Task 2: Tax Amount
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an income amount and tax brackets.
# 
# Write a script to calculate the total tax amount.
# 
# Example 1
# 
#     Input: $income = 10, @tax = ([3, 50], [7, 10], [12,25])
#     Output: 1.65
# 
#     1st tax bracket upto  3, tax is 50%.
#     2nd tax bracket upto  7, tax is 10%.
#     3rd tax bracket upto 12, tax is 25%.
# 
#     Total Tax => (3 * 50/100) + (4 * 10/100) + (3 * 25/100)
#               => 1.50 + 0.40 + 0.75
#               => 2.65
# 
# Example 2
# 
#     Input: $income = 2, @tax = ([1, 0], [4, 25], [5,50])
#     Output: 0.25
# 
#     Total Tax => (1 * 0/100) + (1 * 25/100)
#               => 0 + 0.25
#               => 0.25
# 
# Example 3
# 
#     Input: $income = 0, @tax = ([2, 50])
#     Output: 0
# 

package require tcltest

set cases {
    {{10 {{3 50} {7 10} {12 25}}} 2.65 "Example 1"}
    {{ 2 {{1 0} {4 25} {5 50}}}   0.25 "Example 2"}
    {{ 0 {{2 50}}}                0.0  "Example 3"}
}

proc tax_amount {p} {
    set income [lindex $p 0]
    set tax    [lindex $p 1]

    set total_tax 0.0
    set last_limit 0

    foreach t $tax {
        set limit [lindex $t 0]
        set rate [expr [lindex $t 1] / 100.0]

        if {$income <= $last_limit} {
            break
        }

        if {$income > $limit} {
            set total_tax [expr $total_tax + ($limit - $last_limit) * $rate]
        } else {
            set total_tax [expr $total_tax + ($income - $last_limit) * $rate]
            break
        }
        set last_limit $limit
    }

    return $total_tax
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       tax_amount [lindex $case 0]
    } [lindex $case 1]
}

exit 0


