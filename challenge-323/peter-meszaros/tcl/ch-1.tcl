#!/usr/bin/env tclsh
#
# Task 1: Increment Decrement
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of operations.
# 
# Write a script to return the final value after performing the given operations
# in order. The initial value is always 0.
# 
# Possible Operations:
# 
#     ++x or x++: increment by 1
#     --x or x--: decrement by 1
# 
# Example 1
# 
#     Input: @operations = ("--x", "x++", "x++")
#     Output: 1
# 
#     Operation "--x" =>  0 - 1 => -1
#     Operation "x++" => -1 + 1 =>  0
#     Operation "x++" =>  0 + 1 =>  1
# 
# Example 2
# 
#     Input: @operations = ("x++", "++x", "x++")
#     Output: 3
# 
# Example 3
# 
#     Input: @operations = ("x++", "++x", "--x", "x--")
#     Output: 0
# 
#     Operation "x++" => 0 + 1 => 1
#     Operation "++x" => 1 + 1 => 2
#     Operation "--x" => 2 - 1 => 1
#     Operation "x--" => 1 - 1 => 0
# 

package require tcltest

set cases {
    {{"--x" "x++" "x++"}       1 "Example 1"}
    {{"x++" "++x" "x++"}       3 "Example 2"}
    {{"x++" "++x" "--x" "x--"} 0 "Example 3"}
    {{"x++"  "--y" "x--"}   null "Example 4"}
}

proc increment_decrement {p} {
    set value 0
    foreach op $p {
        if {$op eq "++x" || $op eq "x++"} {
            incr value
        } elseif {$op eq "--x" || $op eq "x--"} {
            incr value -1
        } else {
            return null
        }
    }
    return $value
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       increment_decrement [lindex $case 0]
    } [lindex $case 1]
}

exit 0

