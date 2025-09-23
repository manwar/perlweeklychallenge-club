#!/usr/bin/env tclsh
#
# Task 2: Ascending Numbers
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str, is a list of tokens separated by a single space.
# Every token is either a positive number consisting of digits 0-9 with no
# leading zeros, or a word consisting of lowercase English letters.
# 
# Write a script to check if all the numbers in the given string are strictly
# increasing from left to right.
# 
# Example 1
# 
#     Input: $str = "The cat has 3 kittens 7 toys 10 beds"
#     Output: true
# 
#     Numbers 3, 7, 10 - strictly increasing.
# 
# Example 2
# 
#     Input: $str = 'Alice bought 5 apples 2 oranges 9 bananas'
#     Output: false
# 
# Example 3
# 
#     Input: $str = 'I ran 1 mile 2 days 3 weeks 4 months'
#     Output: true
# 
# Example 4
# 
#     Input: $str = 'Bob has 10 cars 10 bikes'
#     Output: false
# 
# Example 5
# 
#     Input: $str = 'Zero is 0 one is 1 two is 2'
#     Output: true
# 

package require tcltest

set cases {
    {"The cat has 3 kittens 7 toys 10 beds"       1  "Example 1"} 
    {"Alice bought 5 apples 2 oranges 9 bananas"  0  "Example 2"} 
    {"I ran 1 mile 2 days 3 weeks 4 months"       1  "Example 3"} 
    {"Bob has 10 cars 10 bikes"                   0  "Example 4"} 
    {"Zero is 0 one is 1 two is 2"                1  "Example 5"} 
}

proc ascending_numbers {str} {
    set tokens [regexp -all -inline {\d+} $str]
    set last -1
    foreach token $tokens {
        if {$token <= $last} {
            return 0
        }
        set last $token
    }
    return 1
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       ascending_numbers [lindex $case 0]
    } [lindex $case 1]
}

exit 0

